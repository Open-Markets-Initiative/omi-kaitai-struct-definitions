# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v5.0.2026
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 5.0.2026
#   Date: 2/19/2026
#   Specification: NQTVITCHSpecification.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nsmequities_totalview_itch_v5_0_2026
  title: Nasdaq NsmEquities TotalView Itch v5.0.2026
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v5.0.2026'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

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
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::market_participant_position_message': market_participant_position_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_level_message': mwcb_status_level_message
            'message_type::ipo_quoting_period_update': ipo_quoting_period_update
            'message_type::luld_auction_collar_message': luld_auction_collar_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::add_order_no_mpid_attribution_message': add_order_no_mpid_attribution_message
            'message_type::add_order_with_mpid_attribution_message': add_order_with_mpid_attribution_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::non_cross_trade_message': non_cross_trade_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
            'message_type::retail_price_improvement_indicator_message': retail_price_improvement_indicator_message
            'message_type::direct_listing_with_capital_raise_price_discovery_message': direct_listing_with_capital_raise_price_discovery_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Codes'
  stock_directory_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Indicates when a firm is not in compliance with NASDAQ continued listing requirements'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issue as assigned by NASDAQ'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by NASDAQ'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set-up in NASDAQ systems in a live/production, test, or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the NASDAQ security is set up for IPO release'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Indicates which Limit Up / Limit Down price band calculation parameter is to be used for the instrument'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates whether the security is an exchange traded product'
      - id: etp_leverage_factor
        type: u4
        doc: 'Tracks the integral relationship of the ETP to the underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index. Example: An ETP Leverage Factor of 3 and an Inverse value of ''Y'' indicates the ETP will decrease by a value of 3'
  stock_trading_action_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reason_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action reason'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: locate_code
        type: u2
        doc: 'Locate code identifying the security'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  market_participant_position_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the market participant identifier for which the position message is being generated'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: primary_market_maker
        type: u1
        enum: primary_market_maker
        doc: 'Indicates if the market participant firm qualifies as a Primary Market Maker in accordance with NASDAQ marketplace rules'
      - id: market_maker_mode
        type: u1
        enum: market_maker_mode
        doc: 'Indicates the quoting participant''s registration status in relation to SEC Rules 101 and 104 of Regulation M'
      - id: market_participant_state
        type: u1
        enum: market_participant_state
        doc: 'Indicates the market participant''s current registration status in the issue'
  mwcb_decline_level_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: level_1
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  mwcb_status_level_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  ipo_quoting_period_update:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the IPO release time, in seconds since midnight, for quotation to the nearest second'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'IPO Quotation Release Qualifier'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'Denotes the IPO price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
  luld_auction_collar_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: auction_collar_reference_price
        type: decimal_u4_4
        doc: 'Reference price used to set the auction collars. Implied decimal with scale 1e-4'
      - id: upper_auction_collar_price
        type: decimal_u4_4
        doc: 'Indicates the price of the upper auction collar threshold. Implied decimal with scale 1e-4'
      - id: lower_auction_collar_price
        type: decimal_u4_4
        doc: 'Indicates the price of the lower auction collar threshold. Implied decimal with scale 1e-4'
      - id: auction_collar_extension
        type: u4
        doc: 'Indicates the number of extensions to the Reopening Auction'
  operational_halt_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Market Code'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the operational halt action for the security'
  add_order_no_mpid_attribution_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  add_order_with_mpid_attribution_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
      - id: attribution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Nasdaq market participant identifier associated with the entered order'
  order_executed_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
  order_executed_with_price_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays and volume calculations'
      - id: execution_price
        type: decimal_u4_4
        doc: 'The price at which the order execution occurred. Implied decimal with scale 1e-4'
  order_cancel_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: canceled_shares
        type: u4
        doc: 'The number of shares being removed from the display size of the order as the result of a cancellation'
  order_delete_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
  order_replace_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: original_order_reference_number
        type: u8
        doc: 'The original reference number of the order being replaced'
      - id: new_order_reference_number
        type: u8
        doc: 'The new reference number for this order at time of replacement'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  non_cross_trade_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
  cross_trade_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: cross_shares
        type: u8
        doc: 'The number of shares matched in the Nasdaq Cross'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: cross_price
        type: decimal_u4_4
        doc: 'The price at which the cross occurred. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The Nasdaq cross session for which the message is being generated'
  broken_trade_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
  net_order_imbalance_indicator_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: paired_shares
        type: u8
        doc: 'The total number of shares that are eligible to be matched at the Current Reference Price'
      - id: imbalance_shares
        type: u8
        doc: 'The number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'The market side of the order imbalance'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: far_price
        type: decimal_u4_4
        doc: 'A hypothetical auction-clearing price for cross orders only. Implied decimal with scale 1e-4'
      - id: near_price
        type: decimal_u4_4
        doc: 'A hypothetical auction-clearing price for cross orders as well as continuous orders. Implied decimal with scale 1e-4'
      - id: current_reference_price
        type: decimal_u4_4
        doc: 'The price at which the NOII shares are being calculated. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The Nasdaq cross session for which the message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'Indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'
  retail_price_improvement_indicator_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: interest_flag
        type: u1
        enum: interest_flag
        doc: 'Interest Flag'
  direct_listing_with_capital_raise_price_discovery_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Locate Code uniquely assigned to the security symbol for the day'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: open_eligibility_status
        type: u1
        enum: open_eligibility_status
        doc: 'Indicates if the security is eligible to be released for trading'
      - id: minimum_allowable_price
        type: decimal_u4_4
        doc: '20% below Registration Statement Lower Price. Implied decimal with scale 1e-4'
      - id: maximum_allowable_price
        type: decimal_u4_4
        doc: '80% above Registration Statement Highest Price. Implied decimal with scale 1e-4'
      - id: near_execution_price
        type: decimal_u4_4
        doc: 'The current reference price when the DLCR volatility test has successfully passed. Implied decimal with scale 1e-4'
      - id: near_execution_time
        type: u8
        doc: 'The time at which the Near Execution Price was determined'
      - id: lower_price_range_collar
        type: decimal_u4_4
        doc: 'Indicates the price of the Lower Auction Collar Threshold. Implied decimal with scale 1e-4'
      - id: upper_price_range_collar
        type: decimal_u4_4
        doc: 'Indicates the price of the Upper Auction Collar Threshold. Implied decimal with scale 1e-4'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data redistributors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for NASDAQ-listed issues.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Nasaq processes orders based on the most Reg SHO Restriction status value'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'Nasdaq will send out this message only if Nasdaq Operations changes the status of a market participant firm in an issue'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_level_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x4b:
      id: 'ipo_quoting_period_update'
      doc: 'Indicates the anticipated IPO quotation release time of a security.'
    0x4a:
      id: 'luld_auction_collar_message'
      doc: 'Indicates the auction collar thresholds within which a paused security can reopen following a LULD trading pause'
    0x68:
      id: 'operational_halt_message'
      doc: 'An Operational Halt means that there has been an interruption of service on the identified security impacting only the designated Market Center'
    0x41:
      id: 'add_order_no_mpid_attribution_message'
      doc: 'This message will be generated for unattributed orders accepted by the Nasdaq system'
    0x46:
      id: 'add_order_with_mpid_attribution_message'
      doc: 'This message will be generated for attributed orders and quotations accepted by the Nasdaq system'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced'
    0x50:
      id: 'non_cross_trade_message'
      doc: 'Trade Messages should be included in NASDAQ time-and-sales displays as well as volume and other market statistics'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that Nasdaq has completed its cross process for a specific security'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade Message is sent whenever an execution on Nasdaq is broken'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'NASDAQ disseminates NOII data'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both the Bid and Ask for NASDAQ-listed securities.'
    0x4f:
      id: 'direct_listing_with_capital_raise_price_discovery_message'
      doc: 'This message is disseminated only for Direct Listing with Capital Raise (DLCR) securities'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Nasdaq Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_messages'
      doc: 'Always The Last Message Sent In Any Trading Day'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Deficient'
    0x45:
      id: 'delinquent'
      doc: 'Delinquent'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient And Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient And Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent And Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient Delinquent And Bankrupt'
    0x43:
      id: 'creations_and_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'yes_field'
      doc: 'Nasdaq System Only Accepts Round Lot Orders For This Security'
    0x4e:
      id: 'no_field'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security'
  issue_classification:
    0x41:
      id: 'american_depositary_share'
      doc: 'American Depositary Share'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x46:
      id: 'depository_receipt'
      doc: 'Depository Receipt'
    0x49:
      id: 'i_144_a'
      doc: 'I 144 A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary_share'
      doc: 'Ordinary Share'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'right'
      doc: 'Right'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units Of Beneficial Interest'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'not_available'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x5a:
      id: 'non_ipo_new_listed_security'
      doc: 'Nasdaq Listed Instrument Is A Non Ipo New Listed Security'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasda Qlisted Securities Only'
    0x51:
      id: 'quotation_only_period'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'test_restriction_remains'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  primary_market_maker:
    0x59:
      id: 'primary'
      doc: 'Primary Market Maker'
    0x4e:
      id: 'non_primary'
      doc: 'Nonprimary Market Maker'
  market_maker_mode:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x53:
      id: 'syndicate'
      doc: 'Syndicate'
    0x52:
      id: 'pre_syndicate'
      doc: 'Pre Syndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused'
      doc: 'Excused Withdrawn'
    0x57:
      id: 'withdrawn'
      doc: 'Withdrawn'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
  breached_level:
    0x31:
      id: 'level_1'
      doc: 'Level 1'
    0x32:
      id: 'level_2'
      doc: 'Level 2'
    0x33:
      id: 'level_3'
      doc: 'Level 3'
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated_quotation_release_time'
      doc: 'Used When Nasdaq Market Operations Initially Enters The Ipo Instrument For Release'
    0x43:
      id: 'ipo_release_canceled_or_postponed'
      doc: 'Used When Nasdaq Market Operations Cancels Or Postpones The Release Of The New Ipo Instrument'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'trading_resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'no_field'
      doc: 'Nonprintable'
    0x59:
      id: 'yes_field'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'closing'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'halted_or_paused'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x41:
      id: 'extended_close'
      doc: 'Extended Trading Close'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'none'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
    0x50:
      id: 'paused'
      doc: 'Paused'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1_percent'
      doc: 'Less Than 1'
    0x31:
      id: 'less_than_2_percent'
      doc: '1 To 199'
    0x32:
      id: 'less_than_3_percent'
      doc: '2 To 299'
    0x33:
      id: 'less_than_4_percent'
      doc: '3 To 399'
    0x34:
      id: 'less_than_5_percent'
      doc: '4 To 499'
    0x35:
      id: 'less_than_6_percent'
      doc: '5 To 599'
    0x36:
      id: 'less_than_7_percent'
      doc: '6 To 699'
    0x37:
      id: 'less_than_8_percent'
      doc: '7 To 799'
    0x38:
      id: 'less_than_9_percent'
      doc: '8 To 899'
    0x39:
      id: 'less_than_10_percent'
      doc: '9 To 999'
    0x41:
      id: 'less_than_20_percent'
      doc: '10 To 1999'
    0x42:
      id: 'less_than_30_percent'
      doc: '20 To 2999'
    0x43:
      id: 'more_than_30_percent'
      doc: '30 Or Greater'
    0x20:
      id: 'not_available'
      doc: 'Cannot Be Calculated'
  interest_flag:
    0x42:
      id: 'buy_side'
      doc: 'Rpi Orders Available On The Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Rpi Orders Available On The Sell Side'
    0x41:
      id: 'both_sides'
      doc: 'Rpi Orders Available On Both Sides Buy And Sell'
    0x4e:
      id: 'no_rpi_orders_available'
      doc: 'No Rpi Orders Available'
  open_eligibility_status:
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible'
    0x59:
      id: 'eligible'
      doc: 'Eligible'

