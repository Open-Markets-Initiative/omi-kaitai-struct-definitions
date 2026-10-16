# ---------------------------------------------------------------------
# Kaitai struct definition for: Txse TxseEquities Bale Rake v1.0
#
# Protocol:
#   Organization: Texas Stock Exchange
#   Protocol: BALE Top-of-Book Market Data Feed
#   Encoding: RAKE Session and Framing Layer
#   Version: 1.0
#   Date: 6/12/2026
#   Specification: TXSE BALE Top-of-Book Market Data Feed (1.0).pdf
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
  id: txse_txseequities_bale_rake_v1_0
  title: Txse TxseEquities Bale Rake v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities BALE Top-of-Book Market Data Feed Rake v1.0'
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
            'message_type::trade_message': trade_message
            'message_type::top_of_book_message': top_of_book_message
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
        doc: 'Market-wide trading state indicating the default state for all symbols (individual symbols may have additional restrictions)'
      - id: trading_session_status_operational_halt_reason
        type: s1
        enum: trading_session_status_operational_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_operational_halt_reason
        doc: 'Enum TradingSessionStatusOperationalHaltReason. Operational and technical reasons for trading halts initiated by the Exchange'
      - id: trading_session_status_regulatory_halt_reason
        type: s1
        enum: trading_session_status_regulatory_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_regulatory_halt_reason
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
        doc: 'Symbol-specific trading state indicating current availability'
      - id: short_sale_restriction_state
        type: s1
        enum: short_sale_restriction_state
        doc: 'Enum ShortSaleRestrictionState. Short sale restriction state under SEC Rule 201'
      - id: symbol_status_operational_halt_reason
        type: s1
        enum: symbol_status_operational_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_operational_halt_reason
        doc: 'Enum SymbolStatusOperationalHaltReason. Operational and technical reasons for trading halts initiated by the Exchange'
      - id: symbol_status_regulatory_halt_reason
        type: s1
        enum: symbol_status_regulatory_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_regulatory_halt_reason
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
        doc: 'Execution price. Implied decimal with scale 1e-8'
      - id: qty
        type: s4
        doc: 'Execution quantity'
      - id: trade_through_exemption_reason
        type: s1
        enum: trade_through_exemption_reason
        doc: 'Whether this trade is exempt from Reg NMS Rule 611 trade-through protection (CTA/UTP sale condition category/level 2)'
  top_of_book_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: bid_price
        type: decimal_s8_8
        doc: 'Best bid price. Zero when cumulative displayed bid liquidity does not reach a round lot. Implied decimal with scale 1e-8'
      - id: bid_qty
        type: s4
        doc: 'Total cumulative displayed quantity at the BBO bid price and all more aggressive bid prices. Zero when cumulative displayed bid liquidity does not reach a round lot. Capped at the maximum value of a 32-bit signed integer; when the cumulative displayed quantity reaches this cap, the field indicates at least that many shares rather than an exact count'
      - id: ask_price
        type: decimal_s8_8
        doc: 'Best ask price. Zero when cumulative displayed ask liquidity does not reach a round lot. Implied decimal with scale 1e-8'
      - id: ask_qty
        type: s4
        doc: 'Total cumulative displayed quantity at the BBO ask price and all more aggressive ask prices. Zero when cumulative displayed ask liquidity does not reach a round lot. Capped at the maximum value of a 32-bit signed integer; when the cumulative displayed quantity reaches this cap, the field indicates at least that many shares rather than an exact count'
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
        doc: 'Cross execution identifier. Where the feed publishes per-order auction executions, those executions carry this same execId for the cross. Unique per symbol per trading day; not guaranteed unique across symbols or across trading days'
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
    120:
      id: 'trade_message'
      doc: 'An execution report for a single fill event in the order book. Quantity is the number of shares in this execution. An aggressive order that sweeps multiple resting orders produces one Trade per resting order filled.'
    113:
      id: 'top_of_book_message'
      doc: 'Current best bid and offer for a symbol. The BBO is the most aggressive price at which cumulative displayed liquidity reaches a round lot. Quantity is the total displayed shares at the BBO price combined with any displayed shares at more aggressive prices on that side. Price and quantity are zero when cumulative displayed liquidity does not reach a round lot. A TopOfBook is published whenever a depth change occurs at or inside the current BBO on the affected side. A TopOfBook may be published with values identical to the previous one if the net result for the BBO happens to be unchanged after a relevant quantity change. When an execution causes both Trade and TopOfBook messages, all Trade messages from that execution event are delivered before the TopOfBook that reflects the resulting depth change.'
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
      doc: 'Markets are closed before trading hours.'
    1:
      id: 'early_session'
      doc: 'Early trading session is active (pre-market).'
    2:
      id: 'regular_session'
      doc: 'Regular trading session is active.'
    3:
      id: 'after_hours_session'
      doc: 'After-hours trading session is active (post-market).'
    4:
      id: 'closed_after_hours'
      doc: 'Markets are closed after trading hours.'
  session_trading_state:
    0:
      id: 'closed'
      doc: 'Market session is closed - outside of trading hours or not yet opened.'
    1:
      id: 'trading'
      doc: 'Market session is open and trading is active (individual symbols may still be halted/paused).'
    2:
      id: 'halted'
      doc: 'Market-wide trading halt - all symbols halted (circuit breaker or system-wide halt).'
  trading_session_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative or technical halt initiated by the Exchange.'
  trading_session_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason not available or not applicable (CTA: Space, UTP: Space).'
    1:
      id: 'news_pending'
      doc: 'Trading halted pending release of material news (CTA: P, UTP: T1).'
    2:
      id: 'news_dissemination'
      doc: 'Trading halted for dissemination of material news (CTA: D, UTP: T2).'
    3:
      id: 'info_requested'
      doc: 'Additional information requested by the listing exchange (CTA: A, UTP: T12).'
    4:
      id: 'order_imbalance'
      doc: 'Order imbalance (CTA: I).'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary market activity (UTP: T6).'
    6:
      id: 'luld_pause'
      doc: 'Limit Up-Limit Down pause (CTA: M, UTP: LUDP).'
    7:
      id: 'non_compliance'
      doc: 'Non-compliance with listing standards (UTP: H4).'
    8:
      id: 'filings_not_current'
      doc: 'Required filings not current (UTP: H9).'
    9:
      id: 'sec_suspension'
      doc: 'SEC trading suspension (UTP: H10).'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory concern from other markets (CTA: C, UTP: H11).'
    11:
      id: 'sub_penny_trading'
      doc: 'Sub-penny trading violation (CTA: Y).'
    12:
      id: 'etf'
      doc: 'ETF-specific halt (CTA: F, UTP: T8).'
    13:
      id: 'ipo_not_trading'
      doc: 'IPO not yet trading (UTP: IPO1).'
    14:
      id: 'corporate_action'
      doc: 'Corporate action in progress (CTA: N, UTP: M1).'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Market-wide circuit breaker Level 1 (CTA: 1, UTP: MWC1).'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Market-wide circuit breaker Level 2 (CTA: 2, UTP: MWC2).'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Market-wide circuit breaker Level 3 (CTA: 3, UTP: MWC3).'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Market-wide circuit breaker halt carried over from previous trading day (UTP: MWC0).'
    19:
      id: 'merger_effective'
      doc: 'Merger effective (CTA: E).'
    20:
      id: 'new_security_offering'
      doc: 'New security offering (CTA: O).'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday indicative value not available (CTA: V).'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation not available (UTP: M2).'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single stock trading pause (UTP: T5).'
    24:
      id: 'operational'
      doc: 'Non-regulatory halt due to technical or operational reasons (CTA: X, UTP: O1).'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up-Limit Down volatility pause - straddle condition (bid/offer crosses a band) (UTP: LUDS).'
    26:
      id: 'news_resumption_times'
      doc: 'News and resumption times announced (UTP: T3).'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single stock trading pause (UTP: T7).'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications issues reviewed/resolved; quotations/trading to resume (UTP: R4).'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing requirements satisfied/resolved; quotations/trading to resume (UTP: R9).'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer news not forthcoming; quotations/trading to resume (UTP: C3).'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications halt ended; maintenance requirements met; resume (UTP: C4).'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications halt concluded; filings met; quotes/trades to resume (UTP: C9).'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade halt concluded by other regulatory authority; quotes/trades to resume (UTP: C11).'
    34:
      id: 'new_issue_available'
      doc: 'New issue available (UTP: R1).'
    35:
      id: 'issue_available'
      doc: 'Issue available (UTP: R2).'
    36:
      id: 'ipo_quotation_released'
      doc: 'IPO security released for quotation (UTP: IPOQ).'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'IPO security - positioning window extension (UTP: IPOE).'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Market-wide circuit breaker quotation resumption (UTP: MWCQ).'
  symbol_trading_state:
    1:
      id: 'trading'
      doc: 'Symbol is open and available for trading.'
    2:
      id: 'halted'
      doc: 'Trading suspended.'
    3:
      id: 'resume_pending'
      doc: 'Applies only when a symbol is in a non-trading state with an auction cross pending to bring it back into trading.'
  short_sale_restriction_state:
    0:
      id: 'none'
      doc: 'No short sale restriction in effect (CTA: Space, UTP: 0).'
    1:
      id: 'activated'
      doc: 'Restriction activated intra-day (CTA: A, UTP: 1).'
    2:
      id: 'continued'
      doc: 'Restriction carried over from previous trading day (CTA: C, UTP: 2).'
    3:
      id: 'deactivated'
      doc: 'Restriction deactivated intra-day (CTA: D).'
    4:
      id: 'in_effect'
      doc: 'Restriction in effect, status unchanged from previous close (CTA: E).'
  symbol_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative or technical halt initiated by the Exchange.'
  symbol_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason not available or not applicable (CTA: Space, UTP: Space).'
    1:
      id: 'news_pending'
      doc: 'Trading halted pending release of material news (CTA: P, UTP: T1).'
    2:
      id: 'news_dissemination'
      doc: 'Trading halted for dissemination of material news (CTA: D, UTP: T2).'
    3:
      id: 'info_requested'
      doc: 'Additional information requested by the listing exchange (CTA: A, UTP: T12).'
    4:
      id: 'order_imbalance'
      doc: 'Order imbalance (CTA: I).'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary market activity (UTP: T6).'
    6:
      id: 'luld_pause'
      doc: 'Limit Up-Limit Down pause (CTA: M, UTP: LUDP).'
    7:
      id: 'non_compliance'
      doc: 'Non-compliance with listing standards (UTP: H4).'
    8:
      id: 'filings_not_current'
      doc: 'Required filings not current (UTP: H9).'
    9:
      id: 'sec_suspension'
      doc: 'SEC trading suspension (UTP: H10).'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory concern from other markets (CTA: C, UTP: H11).'
    11:
      id: 'sub_penny_trading'
      doc: 'Sub-penny trading violation (CTA: Y).'
    12:
      id: 'etf'
      doc: 'ETF-specific halt (CTA: F, UTP: T8).'
    13:
      id: 'ipo_not_trading'
      doc: 'IPO not yet trading (UTP: IPO1).'
    14:
      id: 'corporate_action'
      doc: 'Corporate action in progress (CTA: N, UTP: M1).'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Market-wide circuit breaker Level 1 (CTA: 1, UTP: MWC1).'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Market-wide circuit breaker Level 2 (CTA: 2, UTP: MWC2).'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Market-wide circuit breaker Level 3 (CTA: 3, UTP: MWC3).'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Market-wide circuit breaker halt carried over from previous trading day (UTP: MWC0).'
    19:
      id: 'merger_effective'
      doc: 'Merger effective (CTA: E).'
    20:
      id: 'new_security_offering'
      doc: 'New security offering (CTA: O).'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday indicative value not available (CTA: V).'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation not available (UTP: M2).'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single stock trading pause (UTP: T5).'
    24:
      id: 'operational'
      doc: 'Non-regulatory halt due to technical or operational reasons (CTA: X, UTP: O1).'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up-Limit Down volatility pause - straddle condition (bid/offer crosses a band) (UTP: LUDS).'
    26:
      id: 'news_resumption_times'
      doc: 'News and resumption times announced (UTP: T3).'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single stock trading pause (UTP: T7).'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications issues reviewed/resolved; quotations/trading to resume (UTP: R4).'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing requirements satisfied/resolved; quotations/trading to resume (UTP: R9).'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer news not forthcoming; quotations/trading to resume (UTP: C3).'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications halt ended; maintenance requirements met; resume (UTP: C4).'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications halt concluded; filings met; quotes/trades to resume (UTP: C9).'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade halt concluded by other regulatory authority; quotes/trades to resume (UTP: C11).'
    34:
      id: 'new_issue_available'
      doc: 'New issue available (UTP: R1).'
    35:
      id: 'issue_available'
      doc: 'Issue available (UTP: R2).'
    36:
      id: 'ipo_quotation_released'
      doc: 'IPO security released for quotation (UTP: IPOQ).'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'IPO security - positioning window extension (UTP: IPOE).'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Market-wide circuit breaker quotation resumption (UTP: MWCQ).'
  trade_through_exemption_reason:
    0:
      id: 'none'
      doc: 'No trade-through exemption.'
    1:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep Order (ISO) (CTA/UTP: ''F'').'
  auction_type:
    1:
      id: 'opening'
      doc: 'Scheduled regular-session cross that establishes the official opening price for a symbol.'
    2:
      id: 'closing'
      doc: 'Scheduled end-of-day cross that establishes the official closing price for a symbol.'
    3:
      id: 'halt'
      doc: 'Reopening cross following a trading halt or LULD trading pause.'
    4:
      id: 'ipo'
      doc: 'Cross for a symbol''s initial public offering.'
  excess_auction_side:
    0:
      id: 'equal'
      doc: 'Buy and sell Auction-Only interest are balanced (equal volume on each side), or no Auction-Only interest is currently in the book.'
    1:
      id: 'buy'
      doc: 'Buy interest exceeds sell interest.'
    2:
      id: 'sell'
      doc: 'Sell interest exceeds buy interest.'

