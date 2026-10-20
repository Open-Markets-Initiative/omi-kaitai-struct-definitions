# ---------------------------------------------------------------------
# Kaitai struct definition for: Athex AthexSecurities RealTime Ids v5.2
#
# Protocol:
#   Organization: Athens Exchange Group
#   Protocol: Athens Exchange Securities Market Real Time Channel
#   Encoding: Information Dissemination System
#   Version: 5.2
#   Date: 11/01/2019
#   Specification: ATHEX OASIS IDS Market Data Feed Specification (5.2).pdf
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
  id: athex_athexsecurities_realtime_ids_v5_2
  title: Athex AthexSecurities RealTime Ids v5.2
  license: GPL-3.0
  endian: be

doc: 'Athens Exchange Group Athens Exchange Securities Market Athens Exchange Securities Market Real Time Channel Ids v5.2'
doc-ref: https://www.athexgroup.gr/en/trade/trading-system

seq:
  - id: soh
    type: u1
    doc: 'First character of every message packet, signalling the beginning of the packet'
  - id: message_header
    type: message_header_struct
    doc: 'Thirty five character header succeeding the Soh character of every message packet'
  - id: message_text
    type:
      switch-on: message_header.message_category
      cases:
        'message_category::control_message': control_message
        'message_category::trade_message': trade_message
        'message_category::quote_message': quote_message
        'message_category::index_message': index_message
        'message_category::instrument_summary_message': instrument_summary_message
        'message_category::cancelled_trade_message': cancelled_trade_message
        'message_category::closing_price_message': closing_price_message
        'message_category::projected_auction_auction_open_projected_close_price_message': projected_auction_auction_open_projected_close_price_message
        'message_category::high_low_limit_modification_message': high_low_limit_modification_message
        'message_category::instrument_state_message': instrument_state_message
        'message_category::market_status_message': market_status_message
        'message_category::order_message': order_message
        'message_category::cancelled_order_message': cancelled_order_message
        'message_category::exchange_notifications_message': exchange_notifications_message
  - id: etx
    type: u1
    doc: 'Signals the end of the packet''s text'
  - id: lrc
    type: u1
    doc: 'Longitudinal Redundancy Check character signalling the packet''s end, the exclusive or of all message bytes from the header up to and including the Etx'

types:
  message_header_struct:
    seq:
      - id: vendor_identifier
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Data Vendor the packet is intended for: two spaces for every vendor, which is the value of every packet sent during the trading session, TV for a test vendor, or a vendor code, which the Ids sends only during retransmission'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Identifies the category of the transmitted message, and selects the Message Text that follows the header'
      - id: message_subcategory
        type: u1
        enum: message_subcategory
        doc: 'Identifies the financial product whose information is conveyed and imposes a second level of categorization upon it. The Ids sends one space when the packet''s category is not directly related to a specific financial product'
      - id: venue_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identification Code of the Exchange or Regulated Market publishing the packet''s information, as Iso 10383 defines it. Control message packets such as Line Verification carry four spaces'
      - id: message_sequence_number
        type: str
        size: 7
        encoding: ASCII
        doc: 'Sequence number of the packet. The first message sent has a sequence number of zero and every message thereafter increments it by one, except a Line Verification control message, which repeats the number of the last message sent. A vendor asks the Ids to retransmit by naming the first and last sequence numbers to send, and a retransmitted packet carries its original number'
      - id: publication_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Local time the packet was created in the Ids subsystem, as YYYYMMDDHHMMSSdddddd to the microsecond'
  control_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The Category''s type'
      - id: control_message_text
        type:
          switch-on: message_type
          cases:
            'message_type::administrative_message': administrative_message
  administrative_message:
    seq:
      - id: free_text
        type: str
        size-eos: true
        encoding: ASCII
        doc: 'The actual message, of any size between one and four hundred characters, written in English'
  trade_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: board_id
        type: u1
        enum: board_id
        doc: 'The trading board under which the instrument is being traded'
      - id: trade_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Unique for the trading day'
      - id: buy_order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The sequence number of the buy side order being matched'
      - id: buy_order_date
        type: yyyymmdd_ascii_date
        doc: 'The date the buy side order was entered into the trading system'
      - id: sell_order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The sequence number of the sell side order being matched'
      - id: sell_order_date
        type: yyyymmdd_ascii_date
        doc: 'The date the sell side order was entered into the trading system'
      - id: price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The trade''s price. Implied decimal with scale 1e-4'
      - id: volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The trade''s volume. Implied decimal with scale 1e-2'
      - id: total_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The total number of stocks or contracts traded up to that point. Implied decimal with scale 1e-2'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Whether the trade is new or an edit of one already reported'
      - id: trade_source
        type: u1
        enum: trade_source
        doc: 'The system the trade came from'
      - id: buy_order_type
        type: u1
        enum: buy_order_type
        doc: 'The type of the buy side order'
      - id: sell_order_type
        type: u1
        enum: sell_order_type
        doc: 'The type of the sell side order'
      - id: buy_waiver_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bitwise field that defines the waivers: bit 1 RFPT reference price, bit 2 NLIQ negotiated liquid, bit 3 OILQ negotiated illiquid, bit 4 PRIC negotiated conditions, bit 5 SIZE above specified size, bit 6 ILQD illiquid instrument'
      - id: sell_waiver_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bitwise field that defines the waivers: bit 1 RFPT reference price, bit 2 NLIQ negotiated liquid, bit 3 OILQ negotiated illiquid, bit 4 PRIC negotiated conditions, bit 5 SIZE above specified size, bit 6 ILQD illiquid instrument'
      - id: notional_amount
        type: str
        size: 14
        encoding: ASCII
        doc: 'Trade value. Implied decimal with scale 1e-2'
      - id: buy_algo_flag
        type: u1
        enum: buy_algo_flag
        doc: 'Algorithmic transaction flag of the buy side. Y is flag on and any other value is flag off'
      - id: sell_algo_flag
        type: u1
        enum: sell_algo_flag
        doc: 'Algorithmic transaction flag of the sell side. Y is flag on and any other value is flag off'
      - id: sdiv_flag
        type: u1
        enum: sdiv_flag
        doc: 'Special Dividend transaction flag. Y is flag on and any other value is flag off'
      - id: dupl_flag
        type: u1
        enum: dupl_flag
        doc: 'Duplicative Trade reports flag. Y is flag on and any other value is flag off'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  quote_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: num_quote_level
        type: str
        size: 3
        encoding: ASCII
        doc: 'The number of Bid and Ask levels contained in this message for the given instrument'
      - id: quote_level
        type: quote_level
        repeat: expr
        repeat-expr: num_quote_level.to_i
        doc: 'One Bid and Ask level of the given instrument, repeated as many times as the Quote Levels field states'
  quote_level:
    seq:
      - id: bid_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best Bid price. Implied decimal with scale 1e-4'
      - id: bid_size
        type: str
        size: 17
        encoding: ASCII
        doc: 'The best Bid volume. Implied decimal with scale 1e-2'
      - id: bid_orders
        type: str
        size: 7
        encoding: ASCII
        doc: 'The number of orders composing the current bid level'
      - id: ask_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best Ask price. Implied decimal with scale 1e-4'
      - id: ask_size
        type: str
        size: 17
        encoding: ASCII
        doc: 'The best Ask volume. Implied decimal with scale 1e-2'
      - id: ask_orders
        type: str
        size: 7
        encoding: ASCII
        doc: 'The number of orders composing the current ask level'
  index_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: index_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The calculated value of the Index. Implied decimal with scale 1e-4'
  instrument_summary_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The Instrument''s opening price. Implied decimal with scale 1e-4'
      - id: high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price with which the given Instrument was traded, during the trading day. Implied decimal with scale 1e-4'
      - id: low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price with which the given Instrument was traded, during the trading day. Implied decimal with scale 1e-4'
      - id: last
        type: str
        size: 9
        encoding: ASCII
        doc: 'The last price with which the given Instrument was traded, during the trading day. Implied decimal with scale 1e-4'
      - id: closing_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The Instrument''s closing price. Implied decimal with scale 1e-4'
      - id: start_of_day_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Usually the previous day''s closing price adjusted, if necessary, from various corporate actions. Implied decimal with scale 1e-4'
      - id: total_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The total number of stocks or contracts traded up to that point. Implied decimal with scale 1e-2'
      - id: total_value
        type: str
        size: 17
        encoding: ASCII
        doc: 'The total value traded in the given Market for the given Instrument, during the trading day. Implied decimal with scale 1e-2'
  cancelled_trade_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: board_id
        type: u1
        enum: board_id
        doc: 'The trading board under which the instrument is being traded'
      - id: trade_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Unique for the trading day'
      - id: buy_order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The sequence number of the buy side order being matched'
      - id: buy_order_date
        type: yyyymmdd_ascii_date
        doc: 'The date the buy side order was entered into the trading system'
      - id: sell_order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The sequence number of the sell side order being matched'
      - id: sell_order_date
        type: yyyymmdd_ascii_date
        doc: 'The date the sell side order was entered into the trading system'
      - id: cancelled_trade_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The price of the cancelled trade. Implied decimal with scale 1e-4'
      - id: cancelled_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The volume of the cancelled trade. Implied decimal with scale 1e-2'
      - id: total_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The total number of stocks or contracts traded up to that point. Implied decimal with scale 1e-2'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Whether the trade is new or an edit of one already reported'
      - id: trade_source
        type: u1
        enum: trade_source
        doc: 'The system the trade came from'
      - id: buy_order_type
        type: u1
        enum: buy_order_type
        doc: 'The type of the buy side order'
      - id: sell_order_type
        type: u1
        enum: sell_order_type
        doc: 'The type of the sell side order'
      - id: buy_waiver_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bitwise field that defines the waivers: bit 1 RFPT reference price, bit 2 NLIQ negotiated liquid, bit 3 OILQ negotiated illiquid, bit 4 PRIC negotiated conditions, bit 5 SIZE above specified size, bit 6 ILQD illiquid instrument'
      - id: sell_waiver_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bitwise field that defines the waivers: bit 1 RFPT reference price, bit 2 NLIQ negotiated liquid, bit 3 OILQ negotiated illiquid, bit 4 PRIC negotiated conditions, bit 5 SIZE above specified size, bit 6 ILQD illiquid instrument'
      - id: notional_amount
        type: str
        size: 14
        encoding: ASCII
        doc: 'Trade value. Implied decimal with scale 1e-2'
      - id: buy_algo_flag
        type: u1
        enum: buy_algo_flag
        doc: 'Algorithmic transaction flag of the buy side. Y is flag on and any other value is flag off'
      - id: sell_algo_flag
        type: u1
        enum: sell_algo_flag
        doc: 'Algorithmic transaction flag of the sell side. Y is flag on and any other value is flag off'
      - id: sdiv_flag
        type: u1
        enum: sdiv_flag
        doc: 'Special Dividend transaction flag. Y is flag on and any other value is flag off'
      - id: dupl_flag
        type: u1
        enum: dupl_flag
        doc: 'Duplicative Trade reports flag. Y is flag on and any other value is flag off'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  closing_price_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: closing
        type: str
        size: 9
        encoding: ASCII
        doc: 'The Instrument''s closing price, as Oasis calculated it. Implied decimal with scale 1e-4'
      - id: open_interest
        type: str
        size: 8
        encoding: ASCII
        doc: 'Total number of outstanding contracts'
  projected_auction_auction_open_projected_close_price_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: price_flag
        type: u1
        enum: price_flag
        doc: 'Which of the three prices the message carries'
      - id: price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The trade''s price. Implied decimal with scale 1e-4'
      - id: volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The trade''s volume. Implied decimal with scale 1e-2'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  high_low_limit_modification_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: ceiling_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The Instrument''s ceiling price. Implied decimal with scale 1e-4'
      - id: floor_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The Instrument''s floor price. Implied decimal with scale 1e-4'
      - id: start_of_day_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Usually the previous day''s closing price adjusted, if necessary, from various corporate actions. Implied decimal with scale 1e-4'
      - id: accrued_interest
        type: str
        size: 14
        encoding: ASCII
        doc: 'For bonds. Implied decimal with scale 1e-6'
  instrument_state_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: phase_id
        type: u1
        enum: phase_id
        doc: 'The Instrument''s trading phase'
      - id: instrument_status
        type: u1
        enum: instrument_status
        doc: 'The Instrument''s status'
      - id: halt_suspend_reason
        type: u1
        enum: halt_suspend_reason
        doc: 'The Reason for Halting or Suspending the Instrument'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  market_status_message:
    seq:
      - id: market_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'The Market''s ID'
      - id: market_status
        type: u1
        enum: market_status
        doc: 'The Market status'
  order_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: board_id
        type: u1
        enum: board_id
        doc: 'The trading board under which the instrument is being traded'
      - id: order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The order''s sequence number'
      - id: order_entry_date
        type: yyyymmdd_ascii_date
        doc: 'The date the order entered the trading system'
      - id: order_status
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The status of the order'
      - id: side
        type: u1
        enum: side
        doc: 'The order''s side'
      - id: volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The trade''s volume. Implied decimal with scale 1e-2'
      - id: matched_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The portion of the order''s Volume that has been matched thus far. Implied decimal with scale 1e-2'
      - id: price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The trade''s price. Implied decimal with scale 1e-4'
      - id: original_price_type
        type: u1
        enum: original_price_type
        doc: 'The original price type'
      - id: order_lifetime
        type: u1
        enum: order_lifetime
        doc: 'The order''s lifetime'
      - id: special_conditions
        type: u1
        enum: special_conditions
        doc: 'The condition of the order if available'
      - id: condition_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The volume pertinent to a special condition of type M or O. Implied decimal with scale 1e-2'
      - id: order_release_date
        type: yyyymmdd_ascii_date
        doc: 'The date the order was released to the Order Book, or for orders that undergo time priority changes the date when that change occurs'
      - id: order_release_time
        type: hhmmssuuuuuu_ascii_time
        doc: 'The time the order was released to the Order Book, or for orders that undergo time priority changes the time at which that change occurs'
      - id: last_order_update_date
        type: yyyymmdd_ascii_date
        doc: 'The date of the last order update or modification'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'The type of the order'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  cancelled_order_message:
    seq:
      - id: symbol
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument''s fifteen character symbol'
      - id: board_id
        type: u1
        enum: board_id
        doc: 'The trading board under which the instrument is being traded'
      - id: order_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'The order''s sequence number'
      - id: order_entry_date
        type: yyyymmdd_ascii_date
        doc: 'The date the order entered the trading system'
      - id: side
        type: u1
        enum: side
        doc: 'The order''s side'
      - id: volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The trade''s volume. Implied decimal with scale 1e-2'
      - id: matched_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The portion of the order''s Volume that has been matched thus far. Implied decimal with scale 1e-2'
      - id: price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The trade''s price. Implied decimal with scale 1e-4'
      - id: original_price_type
        type: u1
        enum: original_price_type
        doc: 'The original price type'
      - id: order_lifetime
        type: u1
        enum: order_lifetime
        doc: 'The order''s lifetime'
      - id: special_conditions
        type: u1
        enum: special_conditions
        doc: 'The condition of the order if available'
      - id: condition_volume
        type: str
        size: 17
        encoding: ASCII
        doc: 'The volume pertinent to a special condition of type M or O. Implied decimal with scale 1e-2'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'The type of the order'
      - id: time_stamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the message was created in the Trading System, as local time to the microsecond'
  exchange_notifications_message:
    seq:
      - id: notification_headline_in_english
        type: str
        size: 72
        encoding: ASCII
        pad-right: 0x20
        doc: 'The headline of the notification in the English language'
      - id: notification_headline_in_local
        type: str
        size: 72
        encoding: ASCII
        pad-right: 0x20
        doc: 'The headline of the notification in the Local language'
      - id: len_english_notification_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'The size of the notification Text written in the English language'
      - id: len_local_notification_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'The size of the notification Text written in the Local language'
      - id: english_notification_text
        type: str
        size: len_english_notification_text.to_i
        encoding: ASCII
        doc: 'The notification Text written in the English language'
      - id: local_notification_text
        type: str
        size: len_local_notification_text.to_i
        encoding: ASCII
        doc: 'The notification Text written in the Local language'
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
  hhmmssuuuuuu_ascii_time:
    seq:
      - id: text
        type: str
        size: 12
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
      microsecond:
        value: text.substring(6, 12).to_i

enums:
  message_category:
    0x4b:
      id: 'control_message'
      doc: 'System specific information the Ids provides to Data Vendors, of one of four types'
    0x41:
      id: 'trade_message'
      doc: 'Transmitted when an instrument trade occurs in the trading platform or the clearing system'
    0x42:
      id: 'quote_message'
      doc: 'Transmitted when at least one side of the supported Quote levels for the given instrument becomes changed. The Ids will not send a Quote level that contains no data'
    0x43:
      id: 'index_message'
      doc: 'Transmitted every time the trading platform calculates the price of a given index'
    0x47:
      id: 'instrument_summary_message'
      doc: 'Transmitted for each instrument right after the corresponding market status changes to End of Day'
    0x49:
      id: 'cancelled_trade_message'
      doc: 'Transmitted when an instrument trade cancellation occurs in the trading platform or clearing system'
    0x4c:
      id: 'closing_price_message'
      doc: 'Transmitted for every instrument whose closing price has been calculated by the trading platform, and again whenever the trading platform recalculates one'
    0x4d:
      id: 'projected_auction_auction_open_projected_close_price_message'
      doc: 'Transmitted whenever the trading platform calculates a Projected Auction, Auction Open or Projected Close price for the instrument'
    0x4e:
      id: 'high_low_limit_modification_message'
      doc: 'Transmitted at the beginning of the trading day, and whenever the static High and Low limits for the given instrument change'
    0x4f:
      id: 'instrument_state_message'
      doc: 'Transmitted at the beginning of the trading day, and whenever the instrument changes its trading phase or its status'
    0x50:
      id: 'market_status_message'
      doc: 'Transmitted whenever the market changes its status'
    0x51:
      id: 'order_message'
      doc: 'Transmitted at the beginning of the trading session for an order whose lifetime spans multiple days, when a new order is entered in the trading platform, and when an already placed order is changed. It is not transmitted for Combinations'
    0x52:
      id: 'cancelled_order_message'
      doc: 'Transmitted whenever an order is cancelled. It is not transmitted for Combinations'
    0x53:
      id: 'exchange_notifications_message'
      doc: 'Transmitted with no predefined triggering event'
  message_subcategory:
    0x20:
      id: 'generic'
      doc: 'Generic, applicable mainly to category K and P messages'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x45:
      id: 'etf'
      doc: 'ETF'
    0x49:
      id: 'stock_index'
      doc: 'Stock Index'
    0x4e:
      id: 'etf_indicative_net_asset_value'
      doc: 'ETF Indicative Net Asset Value (INAV)'
    0x53:
      id: 'stock_rights'
      doc: 'Stock/Rights'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x4f:
      id: 'option'
      doc: 'Option'
    0x46:
      id: 'future'
      doc: 'Future'
    0x52:
      id: 'repos'
      doc: 'Repos'
    0x56:
      id: 'standard_combinations'
      doc: 'Standard Combinations'
  message_type:
    0x41:
      id: 'start_of_day_control_message'
      doc: 'First message transmitted to the Data Vendors, signalling the start of the trading day and that the Ids is ready to process information packets sent by the trading platform'
    0x46:
      id: 'administrative_message'
      doc: 'General information that may be of value to the investors, disseminated whenever the exchange decides'
    0x48:
      id: 'end_of_day_control_message'
      doc: 'Last message transmitted to the Data Vendors, signalling the end of the trading day and that the Ids has concluded its operation'
    0x54:
      id: 'line_verification_control_message'
      doc: 'Transmitted on a minute basis while the data dissemination line remains idle, verifying to the Data Vendors that the Ids continues uninterrupted. It does not increment the Sequence Number and is excluded from retransmission'
  board_id:
    0x4d:
      id: 'main_board'
      doc: 'Main Board'
    0x4f:
      id: 'odd_lot_board'
      doc: 'Odd Lot Board'
    0x42:
      id: 'pre_agreed_board'
      doc: 'Pre-Agreed Board'
    0x53:
      id: 'special_terms_board'
      doc: 'Special Terms (with the Hit and Take Method) Board'
    0x46:
      id: 'forced_sales_board'
      doc: 'Forced Sales (with the Hit and Take Method) Board'
  trade_type:
    0x4e:
      id: 'new_field'
      doc: 'NEW, on a Category A Trade Message'
    0x45:
      id: 'edit'
      doc: 'EDIT, on a Category A Trade Message'
    0x43:
      id: 'cancel'
      doc: 'CANCEL, the only value a Category I Cancelled Trade Message carries'
  trade_source:
    0x54:
      id: 'trading_platform'
      doc: 'Trading Platform'
    0x43:
      id: 'clearing_system'
      doc: 'Clearing System'
  buy_order_type:
    0x42:
      id: 'strategy'
      doc: 'Strategy (Combo)'
    0x51:
      id: 'quote'
      doc: 'Quote'
    0x4e:
      id: 'normal'
      doc: 'Normal'
  sell_order_type:
    0x42:
      id: 'strategy'
      doc: 'Strategy (Combo)'
    0x51:
      id: 'quote'
      doc: 'Quote'
    0x4e:
      id: 'normal'
      doc: 'Normal'
  buy_algo_flag:
    0x59:
      id: 'flag_on'
      doc: 'Flag On'
  sell_algo_flag:
    0x59:
      id: 'flag_on'
      doc: 'Flag On'
  sdiv_flag:
    0x59:
      id: 'flag_on'
      doc: 'Flag On'
  dupl_flag:
    0x59:
      id: 'flag_on'
      doc: 'Flag On'
  price_flag:
    0x30:
      id: 'projected_auction_price'
      doc: 'Projected Auction price'
    0x31:
      id: 'auction_open_price'
      doc: 'Auction Open Price'
    0x32:
      id: 'projected_close'
      doc: 'Projected Close'
  phase_id:
    0x20:
      id: 'start_phase'
      doc: 'Start Phase, sent when an instrument cannot enter any of the listed trading phases'
    0x50:
      id: 'pre_call'
      doc: 'Pre-Call'
    0x54:
      id: 'continuous'
      doc: 'Continuous'
    0x41:
      id: 'atc_orders_released'
      doc: 'Phase where the ATC Orders are released in Order Book'
    0x43:
      id: 'closing_price_trading'
      doc: 'Closing Price Trading'
    0x53:
      id: 'stop'
      doc: 'Stop, which applies only to instruments traded through Call-Auctions and signals the conclusion of the Auction''s opening'
  instrument_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x52:
      id: 'resumed'
      doc: 'Resumed, the beginning of an unscheduled Pre-call period'
  halt_suspend_reason:
    0x20:
      id: 'no_reason'
      doc: 'Default value, no reason'
    0x45:
      id: 'exchange'
      doc: 'Exchange'
    0x56:
      id: 'volatility_interrupter'
      doc: 'Volatility Interrupter'
  market_status:
    0x50:
      id: 'pre_call'
      doc: 'Pre-Call'
    0x4a:
      id: 'projected_auction'
      doc: 'Projected Auction'
    0x54:
      id: 'continuous'
      doc: 'Continuous / Auction Event'
    0x43:
      id: 'closing_price_trading'
      doc: 'Closing Price Trading'
    0x52:
      id: 'run_off'
      doc: 'Run Off, signalling the conclusion of all trading activity pertinent to the instruments listed under the given market'
    0x45:
      id: 'end_of_day'
      doc: 'End of Day'
    0x48:
      id: 'halt'
      doc: 'Halt'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  original_price_type:
    0x4c:
      id: 'limit_price'
      doc: 'Limit price'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4f:
      id: 'at_the_open'
      doc: 'At The Open'
    0x43:
      id: 'at_the_close'
      doc: 'At The Close'
  order_lifetime:
    0x44:
      id: 'day'
      doc: 'Day'
    0x43:
      id: 'good_till_cancel'
      doc: 'Good till cancel'
    0x45:
      id: 'good_till_date'
      doc: 'Good till date'
  special_conditions:
    0x4e:
      id: 'none'
      doc: 'None'
    0x46:
      id: 'fill_or_kill'
      doc: 'Fill or kill'
    0x49:
      id: 'immediate_or_cancel'
      doc: 'Immediate or cancel'
    0x53:
      id: 'stop_instrument'
      doc: 'Stop Instrument'
    0x44:
      id: 'stop_index'
      doc: 'Stop Index'
    0x41:
      id: 'all_or_none'
      doc: 'All or none'
    0x4d:
      id: 'minimum_fill'
      doc: 'Minimum fill'
    0x4f:
      id: 'multiple_of'
      doc: 'Multiple of'
  order_type:
    0x42:
      id: 'strategy'
      doc: 'Strategy (Combo)'
    0x51:
      id: 'quote'
      doc: 'Quote'
    0x4e:
      id: 'normal'
      doc: 'Normal'

