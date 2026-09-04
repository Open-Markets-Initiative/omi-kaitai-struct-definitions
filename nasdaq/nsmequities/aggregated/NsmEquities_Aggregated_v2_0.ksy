# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Aggregated Itch v2.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Aggregated
#   Encoding: Itch
#   Version: 2.0
#   Date: 2/19/2026
#   Specification: TVAggSpecification.pdf
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
  id: nasdaq_nsmequities_aggregated_itch_v2_0
  title: Nasdaq NsmEquities Aggregated Itch v2.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Aggregated Itch v2.0'
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
            'message_type::mwcb_status_message': mwcb_status_message
            'message_type::ipo_quoting_period_update_message': ipo_quoting_period_update_message
            'message_type::luld_auction_collar_message': luld_auction_collar_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::price_level_update_message': price_level_update_message
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
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes below'
  stock_directory_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For Nasdaq-listed issues, indicates when a firm is not in compliance with Nasdaq continued listing requirements'
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
        doc: 'Identifies the security class for the issue as assigned by Nasdaq'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by Nasdaq'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set up in live/production, test, or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the Nasdaq security is set up for IPO release'
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
        doc: 'Indicates the directional relationship between the ETP and Underlying index'
  stock_trading_action_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action reason'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue'
  market_participant_position_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: primary_market_maker
        type: u1
        enum: primary_market_maker
        doc: 'Indicates if the market participant firm qualifies as a Primary Market Maker in accordance with Nasdaq marketplace rules'
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
  mwcb_status_message:
    seq:
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
  ipo_quoting_period_update_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the IPO release time, in seconds since midnight, for quotation to the nearest second'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'Indicates the status of the IPO quotation release'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'Denotes the IPO Price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
  luld_auction_collar_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: auction_collar_reference_price
        type: decimal_u4_4
        doc: 'Reference price used to set the Auction Collars. Implied decimal with scale 1e-4'
      - id: upper_auction_collar_price
        type: decimal_u4_4
        doc: 'Indicates the price of the Upper Auction Collar Threshold. Implied decimal with scale 1e-4'
      - id: lower_auction_collar_price
        type: decimal_u4_4
        doc: 'Indicates the price of the Lower Auction Collar Threshold. Implied decimal with scale 1e-4'
      - id: auction_collar_extension
        type: u4
        doc: 'Indicates the number of the extensions to the Reopening Auction'
  operational_halt_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Identifies the Market Center for which the Operational Halt is declared'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the current operational halt status'
  price_level_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'Denotes the side of the market associated with the price level update'
      - id: participant_shares
        type: u4
        doc: 'Reflects the current number of shares displayed by this participant at this price level'
      - id: aggregate_shares
        type: u4
        doc: 'Reflects the total number of shares displayed in the Nasdaq execution system for ALL participants at this price level'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: price
        type: decimal_u4_4
        doc: 'Reflects the price associated with the update. Implied decimal with scale 1e-4'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the market participant identifier for which the position message is being generated'
  net_order_imbalance_indicator_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
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
        doc: 'The type of Nasdaq cross for which the NOII message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'Indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'
  retail_price_improvement_indicator_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: interest_flag
        type: u1
        enum: interest_flag
        doc: 'Indicates the side(s) on which RPI orders are available'
  direct_listing_with_capital_raise_price_discovery_message:
    seq:
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
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
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
        doc: 'The time at which the near execution price was set'
      - id: lower_price_range_collar
        type: decimal_u4_4
        doc: 'Indicates the price of the Lower Auction Collar Threshold (10% below the Near Execution Price). Implied decimal with scale 1e-4'
      - id: upper_price_range_collar
        type: decimal_u4_4
        doc: 'Indicates the price of the Upper Auction Collar Threshold (10% above the Near Execution Price). Implied decimal with scale 1e-4'
  nanosecond_timestamp:
    seq:
      - id: time
        type: b48
    instances:
      hour:
        value: time.as<s8> / 3600000000000 % 24
      minute:
        value: time.as<s8> / 60000000000 % 60
      second:
        value: time.as<s8> / 1000000000 % 60
      millisecond:
        value: time.as<s8> / 1000000 % 1000
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
      doc: 'Signal a market or data feed handler event'
    0x52:
      id: 'stock_directory_message'
      doc: 'Disseminates stock directory information for all active symbols in the Nasdaq execution system'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Indicates the current trading status of a security to the trading community'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Indicates the Reg SHO Short Sale Price Test Restriction status for a security'
    0x50:
      id: 'market_participant_position_message'
      doc: 'Provides the Primary Market Maker status, Market Maker mode and Market Participant state for each Nasdaq market participant firm registered in an issue'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security'
    0x4a:
      id: 'luld_auction_collar_message'
      doc: 'Indicates the auction collar thresholds within which a paused security can reopen following a LULD Trading Pause'
    0x68:
      id: 'operational_halt_message'
      doc: 'Indicates the current Operational Status of a security specific to the designated Market Center'
    0x55:
      id: 'price_level_update_message'
      doc: 'Disseminated whenever the aggregated position at a price level changes'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'Net Order Imbalance Indicator disseminated for Opening, Closing, Halt/IPO/Pause, and Extended Trading Close crosses'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both for Nasdaq-listed securities'
    0x4f:
      id: 'direct_listing_with_capital_raise_price_discovery_message'
      doc: 'Disseminated only for Direct Listing with Capital Raise securities once per second after the DLCR volatility test has successfully passed'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Indicates That Market Hours Orders Are Available For Execution'
    0x58:
      id: 'clear_noii'
      doc: 'Signals That Firms May Clear Noii Cache For The Regular Opening Cross'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Indicates That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders'
    0x43:
      id: 'end_of_messages'
      doc: 'Always The Last Message Sent In Any Trading Day'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Listed Instrument'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Listed Instrument'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Listed Instrument'
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'Non Nasdaq Listed Instrument'
    0x41:
      id: 'nyse_american'
      doc: 'Non Nasdaq Listed Instrument'
    0x50:
      id: 'nyse_arca'
      doc: 'Non Nasdaq Listed Instrument'
    0x4d:
      id: 'nyse_texas'
      doc: 'Non Nasdaq Listed Instrument'
    0x5a:
      id: 'bats_z_exchange'
      doc: 'Non Nasdaq Listed Instrument'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Non Nasdaq Listed Instrument'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Nasdaq Listed Instrument'
    0x45:
      id: 'delinquent'
      doc: 'Nasdaq Listed Instrument'
    0x51:
      id: 'bankrupt'
      doc: 'Nasdaq Listed Instrument'
    0x53:
      id: 'suspended'
      doc: 'Nasdaq Listed Instrument'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Nasdaq Listed Instrument'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Nasdaq Listed Instrument'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Nasdaq Listed Instrument'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Nasdaq Listed Instrument'
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Nasdaq Listed Instrument'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Non Nasdaq Listed Instrument'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq System Only Accepts Round Lots'
    0x4e:
      id: 'no_restriction'
      doc: 'Odd And Mixed Lot Orders Are Allowed'
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
      id: 'sec_144_a'
      doc: 'Sec 144 A'
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
      id: 'units_benif_int'
      doc: 'Units Benif Int'
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
      id: 'ipo_security'
      doc: 'Nasdaq System Only Accepts Round Lot Orders For This Security'
    0x4e:
      id: 'not_ipo'
      doc: 'No Order Size Restrictions Odd And Mixed Lot Orders Are Allowed'
    0x5a:
      id: 'non_ipo_new_listed'
      doc: 'Nasdaqlisted Instrument Is A Non Ipo New Listed Security'
    0x20:
      id: 'not_available'
      doc: 'Non Nasdaq Listed Instrument'
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
      id: 'inverse'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse'
      doc: 'Etp Is Not An Inverse Etp'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasdaqlisted Securities Only'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'restriction_remains_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  primary_market_maker:
    0x59:
      id: 'primary_market_maker'
      doc: 'Primary Market Maker'
    0x4e:
      id: 'non_primary_market_maker'
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
      doc: 'Presyndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused_withdrawn'
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
      id: 'ipo_release_canceled_postponed'
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
      id: 'operationally_halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'trading_resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'
  market_side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
    0x50:
      id: 'paused'
      doc: 'Paused'
  cross_type:
    0x4f:
      id: 'nasdaq_opening_cross'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'nasdaq_closing_cross'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'cross_for_ipo_and_halted_paused_securities'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x41:
      id: 'extended_trading_close'
      doc: 'Extended Trading Close'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1'
      doc: 'Less Than 1'
    0x31:
      id: 'one_to_one_point_nine_nine_percent'
      doc: '1 To 199'
    0x32:
      id: 'two_to_two_point_nine_nine_percent'
      doc: '2 To 299'
    0x33:
      id: 'three_to_three_point_nine_nine_percent'
      doc: '3 To 399'
    0x34:
      id: 'four_to_four_point_nine_nine_percent'
      doc: '4 To 499'
    0x35:
      id: 'five_to_five_point_nine_nine_percent'
      doc: '5 To 599'
    0x36:
      id: 'six_to_six_point_nine_nine_percent'
      doc: '6 To 699'
    0x37:
      id: 'seven_to_seven_point_nine_nine_percent'
      doc: '7 To 799'
    0x38:
      id: 'eight_to_eight_point_nine_nine_percent'
      doc: '8 To 899'
    0x39:
      id: 'nine_to_nine_point_nine_nine_percent'
      doc: '9 To 999'
    0x41:
      id: 'ten_to_nineteen_point_nine_nine_percent'
      doc: '10 To 1999'
    0x42:
      id: 'twenty_to_twenty_nine_point_nine_nine_percent'
      doc: '20 To 2999'
    0x43:
      id: 'thirty_percent_or_greater'
      doc: '30 Or Greater'
    0x20:
      id: 'cannot_be_calculated'
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
      id: 'no_rpi_orders'
      doc: 'No Rpi Orders Available'
  open_eligibility_status:
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible To Be Released For Trading'
    0x59:
      id: 'eligible'
      doc: 'Eligible To Be Released For Trading'

