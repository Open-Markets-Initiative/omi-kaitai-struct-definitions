# ---------------------------------------------------------------------
# Kaitai struct definition for: Txse TxseEquities Feed Rake v1.0
#
# Protocol:
#   Organization: Texas Stock Exchange
#   Protocol: FEED Full-Depth Market Data
#   Encoding: RAKE Session and Framing Layer
#   Version: 1.0
#   Date: 6/12/2026
#   Specification: FEED.pdf
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
  id: txse_txseequities_feed_rake_v1_0
  title: Txse TxseEquities Feed Rake v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities FEED Full-Depth Market Data Rake v1.0'
doc-ref: https://www.txse.com

seq:
  - id: udp_header
    type: udp_header_struct
    doc: 'Rake Udp packet header'
  - id: udp_sequenced_message
    type: udp_sequenced_message_struct
    repeat: expr
    repeat-expr: udp_header.message_count
    doc: 'Each individual message has a length, a stream id, a message type, and an application payload'

types:
  udp_header_struct:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session. Changes daily and matches the trading session fields on other protocols'
      - id: sequence
        type: u8
        doc: 'The message sequence number of the first message in the payload. Members should increment their message sequence based on the number of messages in the payload'
      - id: message_count
        type: u2
        doc: 'The number of messages in the payload'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Enum RakeUdpPacketType. Identifies the Rake Udp packet variant. Informational only'
  udp_sequenced_message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message, exclusive of the length field itself. Note: inclusive of the streamId byte'
      - id: stream_id
        type: u1
        doc: 'The internal Exchange StreamID that created this message'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: payload
        size: message_length - 2
        type:
          switch-on: message_type
          cases:
            'message_type::trading_session_status_message': trading_session_status_message
            'message_type::define_symbol_message': define_symbol_message
            'message_type::symbol_status_message': symbol_status_message
            'message_type::add_order_message': add_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::execute_order_message': execute_order_message
            'message_type::execute_order_with_price_message': execute_order_with_price_message
            'message_type::modify_size_down_message': modify_size_down_message
            'message_type::replace_order_message': replace_order_message
            'message_type::trade_message': trade_message
            'message_type::break_trade_message': break_trade_message
            'message_type::auction_preamble_message': auction_preamble_message
            'message_type::auction_band_window_message': auction_band_window_message
            'message_type::auction_print_message': auction_print_message
  trading_session_status_message:
    seq:
      - id: trading_session_status_presence_bits
        type: trading_session_status_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: market_hours_state
        type: s1
        enum: market_hours_state
        doc: 'Enum MarketHoursState. Current phase of the market trading day'
      - id: session_trading_state
        type: s1
        enum: session_trading_state
        doc: 'Enum SessionTradingState. Market-wide trading state indicating the default state for all symbols (individual symbols may have additional restrictions)'
      - id: trading_session_status_operational_halt_reason
        type: s1
        enum: trading_session_status_operational_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_operational_halt_reason == 1
        doc: 'Enum TradingSessionStatusOperationalHaltReason. Operational and technical reasons for trading halts initiated by the Exchange'
      - id: trading_session_status_regulatory_halt_reason
        type: s1
        enum: trading_session_status_regulatory_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_regulatory_halt_reason == 1
        doc: 'Enum TradingSessionStatusRegulatoryHaltReason. Regulatory reasons for trading halts and pauses'
  trading_session_status_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_trading_session_status_operational_halt_reason
        type: b1
        doc: 'Set when tradingSessionStatusOperationalHaltReason is present'
      - id: has_trading_session_status_regulatory_halt_reason
        type: b1
        doc: 'Set when tradingSessionStatusRegulatoryHaltReason is present'
      - id: reserved_6
        type: b6
        doc: 'Reserved for future use'
  define_symbol_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier root represented in CMS format'
      - id: suffix
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier suffix represented in CMS format'
      - id: matching_engine_id
        type: s1
        doc: 'The matching engine to which this symbol is assigned for the trading session'
      - id: define_symbol_bit_fields
        type: define_symbol_bit_fields
        doc: 'Bitfield used in messages that reference defineSymbolBitFields'
      - id: lot_size
        type: s4
        doc: 'The number of shares constituting one round lot'
      - id: listing_market
        type: s1
        doc: 'Market participant identifier of the listing exchange. Set to TXSE when TXSE is the listing market for this symbol; NOT_AVAILABLE (0x00) otherwise'
  define_symbol_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: is_test
        type: b1
        doc: 'Test symbol flag'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  symbol_status_message:
    seq:
      - id: symbol_status_presence_bits
        type: symbol_status_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: symbol_trading_state
        type: s1
        enum: symbol_trading_state
        doc: 'Enum SymbolTradingState. Symbol-specific trading state indicating current availability'
      - id: short_sale_restriction_state
        type: s1
        enum: short_sale_restriction_state
        doc: 'Enum ShortSaleRestrictionState. Short sale restriction state under SEC Rule 201'
      - id: symbol_status_operational_halt_reason
        type: s1
        enum: symbol_status_operational_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_operational_halt_reason == 1
        doc: 'Enum SymbolStatusOperationalHaltReason. Operational and technical reasons for trading halts initiated by the Exchange'
      - id: symbol_status_regulatory_halt_reason
        type: s1
        enum: symbol_status_regulatory_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_regulatory_halt_reason == 1
        doc: 'Enum SymbolStatusRegulatoryHaltReason. Regulatory reasons for trading halts and pauses'
  symbol_status_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_symbol_status_operational_halt_reason
        type: b1
        doc: 'Set when symbolStatusOperationalHaltReason is present'
      - id: has_symbol_status_regulatory_halt_reason
        type: b1
        doc: 'Set when symbolStatusRegulatoryHaltReason is present'
      - id: reserved_6
        type: b6
        doc: 'Reserved for future use'
  add_order_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: order_id
        type: s8
        doc: 'Order identifier'
      - id: order_bit_fields
        type: order_bit_fields
        doc: 'Bitfield used in messages that reference orderBitFields'
      - id: price
        type: decimal_s8_8
        doc: 'Price. Implied decimal with scale 1e-8'
      - id: qty
        type: s4
        doc: 'Quantity'
  order_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: is_buy
        type: b1
        doc: 'True if resting displayed order is a bid/buy, false if resting displayed order is an offer/sell'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  delete_order_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: order_id
        type: s8
        doc: 'Order identifier'
  execute_order_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: order_id
        type: s8
        doc: 'Order identifier'
      - id: qty
        type: s4
        doc: 'Quantity'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
  execute_order_with_price_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: order_id
        type: s8
        doc: 'Order identifier'
      - id: qty
        type: s4
        doc: 'Quantity'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
      - id: exec_price
        type: decimal_s8_8
        doc: 'Execution price. Implied decimal with scale 1e-8'
      - id: execution_bit_fields
        type: execution_bit_fields
        doc: 'Bitfield used in messages that reference executionBitFields'
  execution_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: is_included_in_auction_print
        type: b1
        doc: 'True when this execution belongs to an auction cross. The execId matches the AuctionPrint for the same cross'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  modify_size_down_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: order_id
        type: s8
        doc: 'Order identifier'
      - id: qty
        type: s4
        doc: 'Quantity'
  replace_order_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: old_order_id
        type: s8
        doc: 'Old order identifier which will no longer be used for this trading day'
      - id: new_order_id
        type: s8
        doc: 'New order identifier by which activity for this order will be tracked'
      - id: price
        type: decimal_s8_8
        doc: 'Price. Implied decimal with scale 1e-8'
      - id: qty
        type: s4
        doc: 'Quantity'
  trade_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Price. Implied decimal with scale 1e-8'
      - id: qty
        type: s4
        doc: 'Quantity'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
  break_trade_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
  auction_preamble_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: auction_type
        type: s1
        enum: auction_type
        doc: 'Enum AuctionType. Type of auction event'
      - id: auction_start
        type: nanosecond_timestamp
        doc: 'Scheduled cross time for this auction, expressed as nanoseconds since the Unix epoch (UTC). For Opening and Closing auctions, reflects the Exchange''s published session schedule. For Halt and IPO auctions, reflects the cross time announced for this specific event. Nanoseconds since Unix epoch'
      - id: matched_shares
        type: s4
        doc: 'Projected matched volume among Auction-Only orders'
      - id: excess_auction_side
        type: s1
        enum: excess_auction_side
        doc: 'Enum ExcessAuctionSide. Side with surplus Auction-Only volume'
      - id: reserved_8
        type: s8
        doc: 'Reserved for future use. Set to 0 by the Exchange; receivers must ignore'
  auction_band_window_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: auction_type
        type: s1
        enum: auction_type
        doc: 'Enum AuctionType. Type of auction event'
      - id: auction_start
        type: nanosecond_timestamp
        doc: 'Scheduled cross time for this auction, expressed as nanoseconds since the Unix epoch (UTC). For Opening and Closing auctions, reflects the Exchange''s published session schedule. For Halt and IPO auctions, reflects the cross time announced for this specific event. Nanoseconds since Unix epoch'
      - id: extension_cycle_count
        type: s1
        doc: 'Extension cycle number. 0 on the first Band Window cycle. Incremented by 1 on each extension triggered by a projected clearing price outside the Participation Band. Always 0 for OPENING and CLOSING auctions, which do not support Band Window extensions'
      - id: lower_participation_band
        type: decimal_s8_8
        doc: 'Price of the lower boundary of the Participation Band. Auction-Only sell orders entered during the Band Window and priced below this value have their price adjusted to this price. Implied decimal with scale 1e-8'
      - id: buy_shares_at_lower
        type: s4
        doc: 'Total shares of Auction-Only buy interest eligible to execute if the auction cleared at the lower Participation Band boundary'
      - id: sell_shares_at_lower
        type: s4
        doc: 'Total shares of Auction-Only sell interest eligible to execute if the auction cleared at the lower Participation Band boundary'
      - id: upper_participation_band
        type: decimal_s8_8
        doc: 'Price of the upper boundary of the Participation Band. Auction-Only buy orders entered during the Band Window and priced above this value have their price adjusted to this price. Implied decimal with scale 1e-8'
      - id: buy_shares_at_upper
        type: s4
        doc: 'Total shares of Auction-Only buy interest eligible to execute if the auction cleared at the upper Participation Band boundary'
      - id: sell_shares_at_upper
        type: s4
        doc: 'Total shares of Auction-Only sell interest eligible to execute if the auction cleared at the upper Participation Band boundary'
      - id: reserved_8
        type: s8
        doc: 'Reserved for future use. Set to 0 by the Exchange; receivers must ignore'
  auction_print_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: auction_type
        type: s1
        enum: auction_type
        doc: 'Enum AuctionType. Type of auction event'
      - id: auction_price
        type: decimal_s8_8
        doc: 'Auction clearing price. Implied decimal with scale 1e-8'
      - id: matched_shares
        type: s4
        doc: 'Projected matched volume among Auction-Only orders'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  packet_type:
    0:
      id: 'sequenced_data'
      doc: 'Sequenced data packet.'
    1:
      id: 'heartbeat'
      doc: 'Heartbeat only. Sequence is set to the next expected sequence and the message count is 0.'
    2:
      id: 'start_of_session'
      doc: 'First packet of the session. Both the sequence and message count are 0. May repeat multiple times.'
    3:
      id: 'end_of_session'
      doc: 'Last packet of the session. Sequence is the highest known for the session; count is 0. Repeats at some small interval. No payload data is sent after the first EOS packet.'
    4:
      id: 'gap_fill_request'
      doc: 'Reserved for future use.'
    5:
      id: 'gap_fill_response'
      doc: 'Reserved for future use.'
  message_type:
    105:
      id: 'trading_session_status_message'
      doc: 'Market-wide status representing the overall state of the trading session.'
    115:
      id: 'define_symbol_message'
      doc: 'Symbol definition containing instrument details and trading parameters for a security. A DefineSymbol will be followed by a SymbolStatus message establishing the initial trading state for the symbol. Clients must treat a symbol as operationally HALTED while awaiting the accompanying SymbolStatus.'
    121:
      id: 'symbol_status_message'
      doc: 'Symbol-specific trading status representing the current state and restrictions for an individual security. A SymbolStatus is sent for every symbol, including those that open in the TRADING state. Clients must treat a symbol as operationally HALTED while awaiting the first SymbolStatus. Subsequent SymbolStatus messages are sent whenever the trading state or short-sale restriction changes.'
    97:
      id: 'add_order_message'
      doc: 'Details for a newly added order for display to the TXSE book.'
    100:
      id: 'delete_order_message'
      doc: 'Details for an order deleted in its entirety from the TXSE book.'
    101:
      id: 'execute_order_message'
      doc: 'Indicates that an order displayed on the TXSE book has executed in part or in full at its previously displayed price.'
    112:
      id: 'execute_order_with_price_message'
      doc: 'Indicates that an order displayed on the TXSE book has executed in part or in full at this specified price.'
    109:
      id: 'modify_size_down_message'
      doc: 'Modify an order by reducing its size without losing priority on the TXSE book.'
    114:
      id: 'replace_order_message'
      doc: 'Replace an order, possibly changing price level and size (which can increase), losing priority on the TXSE book.'
    116:
      id: 'trade_message'
      doc: 'Execution of non-displayed liquidity.'
    98:
      id: 'break_trade_message'
      doc: 'Break a previous trade or execution by execution identifier.'
    117:
      id: 'auction_preamble_message'
      doc: 'Published every 5 seconds during the Accumulation Period to indicate projected auction size. Reports the matched volume and excess side that would result if the auction crossed at that moment, considering only Auction-Only orders; the Continuous Book is excluded. Emitted for OPENING and CLOSING auction types only. Not emitted for HALT or IPO auctions, which proceed directly to the Band Window phase at onset (see AuctionBandWindow).'
    118:
      id: 'auction_band_window_message'
      doc: 'Published every 5 seconds during the Band Window to report Auction-Only volume positioned at each Participation Band boundary. The Participation Band is a volatility-based price range; its derivation methodology is described in the Participation Bands specification. Auction-Only orders entered during the Band Window that are priced outside the band have their price adjusted to the nearest boundary. The Continuous Book is excluded. Volume counting at boundaries: a limit order is counted at each boundary price at which it would be eligible to execute; a market order is counted at both boundaries. Example: a limit buy at $10.05 counts at the lower boundary if lower = $10.05, but not at the upper boundary if upper = $10.10.'
    110:
      id: 'auction_print_message'
      doc: 'Summary of an auction cross. Emitted before any per-order auction execution messages for the same cross. Universal lifecycle terminator — emitted for every auction. Encoding: (a) matchedShares > 0 with a valid auctionPrice indicates a normal cross; (b) matchedShares = 0 with a valid auctionPrice indicates a zero-share completion (e.g., halt-into-close default or demand failure); (c) matchedShares = 0 with auctionPrice = CANCELED_SENTINEL indicates a canceled auction. Where the feed publishes per-order auction executions, those executions share this message''s execId.'
  market_hours_state:
    0:
      id: 'closed_before_hours'
      doc: 'Markets Are Closed Before Trading Hours'
    1:
      id: 'early_session'
      doc: 'Early Trading Session Is Active Premarket'
    2:
      id: 'regular_session'
      doc: 'Regular Trading Session Is Active'
    3:
      id: 'after_hours_session'
      doc: 'Afterhours Trading Session Is Active Postmarket'
    4:
      id: 'closed_after_hours'
      doc: 'Markets Are Closed After Trading Hours'
  session_trading_state:
    0:
      id: 'closed'
      doc: 'Market Session Is Closed Outside Of Trading Hours Or Not Yet Opened'
    1:
      id: 'trading'
      doc: 'Market Session Is Open And Trading Is Active Individual Symbols May Still Be Haltedpaused'
    2:
      id: 'halted'
      doc: 'Marketwide Trading Halt All Symbols Halted Circuit Breaker Or Systemwide Halt'
  trading_session_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative Or Technical Halt Initiated By The Exchange'
  trading_session_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason Not Available Or Not Applicable Cta Space Utp Space'
    1:
      id: 'news_pending'
      doc: 'Trading Halted Pending Release Of Material News Cta P Utp T 1'
    2:
      id: 'news_dissemination'
      doc: 'Trading Halted For Dissemination Of Material News Cta D Utp T 2'
    3:
      id: 'info_requested'
      doc: 'Additional Information Requested By The Listing Exchange Cta A Utp T 12'
    4:
      id: 'order_imbalance'
      doc: 'Order Imbalance Cta I'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary Market Activity Utp T 6'
    6:
      id: 'luld_pause'
      doc: 'Limit Up Limit Down Pause Cta M Utp Ludp'
    7:
      id: 'non_compliance'
      doc: 'Noncompliance With Listing Standards Utp H 4'
    8:
      id: 'filings_not_current'
      doc: 'Required Filings Not Current Utp H 9'
    9:
      id: 'sec_suspension'
      doc: 'Sec Trading Suspension Utp H 10'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern From Other Markets Cta C Utp H 11'
    11:
      id: 'sub_penny_trading'
      doc: 'Subpenny Trading Violation Cta Y'
    12:
      id: 'etf'
      doc: 'Et Fspecific Halt Cta F Utp T 8'
    13:
      id: 'ipo_not_trading'
      doc: 'Ipo Not Yet Trading Utp Ipo 1'
    14:
      id: 'corporate_action'
      doc: 'Corporate Action In Progress Cta N Utp M 1'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Marketwide Circuit Breaker Level 1 Cta 1 Utp Mwc 1'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Marketwide Circuit Breaker Level 2 Cta 2 Utp Mwc 2'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Marketwide Circuit Breaker Level 3 Cta 3 Utp Mwc 3'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Marketwide Circuit Breaker Halt Carried Over From Previous Trading Day Utp Mwc 0'
    19:
      id: 'merger_effective'
      doc: 'Merger Effective Cta E'
    20:
      id: 'new_security_offering'
      doc: 'New Security Offering Cta O'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available Cta V'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation Not Available Utp M 2'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single Stock Trading Pause Utp T 5'
    24:
      id: 'operational'
      doc: 'Nonregulatory Halt Due To Technical Or Operational Reasons Cta X Utp O 1'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up Limit Down Volatility Pause Straddle Condition Bidoffer Crosses A Band Utp Luds'
    26:
      id: 'news_resumption_times'
      doc: 'News And Resumption Times Announced Utp T 3'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single Stock Trading Pause Utp T 7'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications Issues Reviewedresolved Quotationstrading To Resume Utp R 4'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing Requirements Satisfiedresolved Quotationstrading To Resume Utp R 9'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer News Not Forthcoming Quotationstrading To Resume Utp C 3'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications Halt Ended Maintenance Requirements Met Resume Utp C 4'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications Halt Concluded Filings Met Quotestrades To Resume Utp C 9'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade Halt Concluded By Other Regulatory Authority Quotestrades To Resume Utp C 11'
    34:
      id: 'new_issue_available'
      doc: 'New Issue Available Utp R 1'
    35:
      id: 'issue_available'
      doc: 'Issue Available Utp R 2'
    36:
      id: 'ipo_quotation_released'
      doc: 'Ipo Security Released For Quotation Utp Ipoq'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'Ipo Security Positioning Window Extension Utp Ipoe'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Marketwide Circuit Breaker Quotation Resumption Utp Mwcq'
  symbol_trading_state:
    1:
      id: 'trading'
      doc: 'Symbol Is Open And Available For Trading'
    2:
      id: 'halted'
      doc: 'Trading Suspended'
    3:
      id: 'resume_pending'
      doc: 'Applies Only When A Symbol Is In A Nontrading State With An Auction Cross Pending To Bring It Back Into Trading'
  short_sale_restriction_state:
    0:
      id: 'none'
      doc: 'No Short Sale Restriction In Effect Cta Space Utp 0'
    1:
      id: 'activated'
      doc: 'Restriction Activated Intraday Cta A Utp 1'
    2:
      id: 'continued'
      doc: 'Restriction Carried Over From Previous Trading Day Cta C Utp 2'
    3:
      id: 'deactivated'
      doc: 'Restriction Deactivated Intraday Cta D'
    4:
      id: 'in_effect'
      doc: 'Restriction In Effect Status Unchanged From Previous Close Cta E'
  symbol_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative Or Technical Halt Initiated By The Exchange'
  symbol_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason Not Available Or Not Applicable Cta Space Utp Space'
    1:
      id: 'news_pending'
      doc: 'Trading Halted Pending Release Of Material News Cta P Utp T 1'
    2:
      id: 'news_dissemination'
      doc: 'Trading Halted For Dissemination Of Material News Cta D Utp T 2'
    3:
      id: 'info_requested'
      doc: 'Additional Information Requested By The Listing Exchange Cta A Utp T 12'
    4:
      id: 'order_imbalance'
      doc: 'Order Imbalance Cta I'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary Market Activity Utp T 6'
    6:
      id: 'luld_pause'
      doc: 'Limit Up Limit Down Pause Cta M Utp Ludp'
    7:
      id: 'non_compliance'
      doc: 'Noncompliance With Listing Standards Utp H 4'
    8:
      id: 'filings_not_current'
      doc: 'Required Filings Not Current Utp H 9'
    9:
      id: 'sec_suspension'
      doc: 'Sec Trading Suspension Utp H 10'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern From Other Markets Cta C Utp H 11'
    11:
      id: 'sub_penny_trading'
      doc: 'Subpenny Trading Violation Cta Y'
    12:
      id: 'etf'
      doc: 'Et Fspecific Halt Cta F Utp T 8'
    13:
      id: 'ipo_not_trading'
      doc: 'Ipo Not Yet Trading Utp Ipo 1'
    14:
      id: 'corporate_action'
      doc: 'Corporate Action In Progress Cta N Utp M 1'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Marketwide Circuit Breaker Level 1 Cta 1 Utp Mwc 1'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Marketwide Circuit Breaker Level 2 Cta 2 Utp Mwc 2'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Marketwide Circuit Breaker Level 3 Cta 3 Utp Mwc 3'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Marketwide Circuit Breaker Halt Carried Over From Previous Trading Day Utp Mwc 0'
    19:
      id: 'merger_effective'
      doc: 'Merger Effective Cta E'
    20:
      id: 'new_security_offering'
      doc: 'New Security Offering Cta O'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available Cta V'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation Not Available Utp M 2'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single Stock Trading Pause Utp T 5'
    24:
      id: 'operational'
      doc: 'Nonregulatory Halt Due To Technical Or Operational Reasons Cta X Utp O 1'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up Limit Down Volatility Pause Straddle Condition Bidoffer Crosses A Band Utp Luds'
    26:
      id: 'news_resumption_times'
      doc: 'News And Resumption Times Announced Utp T 3'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single Stock Trading Pause Utp T 7'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications Issues Reviewedresolved Quotationstrading To Resume Utp R 4'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing Requirements Satisfiedresolved Quotationstrading To Resume Utp R 9'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer News Not Forthcoming Quotationstrading To Resume Utp C 3'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications Halt Ended Maintenance Requirements Met Resume Utp C 4'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications Halt Concluded Filings Met Quotestrades To Resume Utp C 9'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade Halt Concluded By Other Regulatory Authority Quotestrades To Resume Utp C 11'
    34:
      id: 'new_issue_available'
      doc: 'New Issue Available Utp R 1'
    35:
      id: 'issue_available'
      doc: 'Issue Available Utp R 2'
    36:
      id: 'ipo_quotation_released'
      doc: 'Ipo Security Released For Quotation Utp Ipoq'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'Ipo Security Positioning Window Extension Utp Ipoe'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Marketwide Circuit Breaker Quotation Resumption Utp Mwcq'
  auction_type:
    1:
      id: 'opening'
      doc: 'Scheduled Regularsession Cross That Establishes The Official Opening Price For A Symbol'
    2:
      id: 'closing'
      doc: 'Scheduled Endofday Cross That Establishes The Official Closing Price For A Symbol'
    3:
      id: 'halt'
      doc: 'Reopening Cross Following A Trading Halt Or Luld Trading Pause'
    4:
      id: 'ipo'
      doc: 'Cross For A Symbols Initial Public Offering'
  excess_auction_side:
    0:
      id: 'equal'
      doc: 'Buy And Sell Auction Only Interest Are Balanced Equal Volume On Each Side Or No Auction Only Interest Is Currently In The Book'
    1:
      id: 'buy'
      doc: 'Buy Interest Exceeds Sell Interest'
    2:
      id: 'sell'
      doc: 'Sell Interest Exceeds Buy Interest'

