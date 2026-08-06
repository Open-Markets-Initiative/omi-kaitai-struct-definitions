# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities NoiView Itch v3.0.2017
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Net Order Imbalance View
#   Encoding: Itch
#   Version: 3.0.2017
#   Date: 9/12/2017
#   Specification: NOIViewSpecification.pdf
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
  id: nsmequities_noiview_v3_0_2017
  title: Nasdaq NsmEquities NoiView Itch v3.0.2017
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Net Order Imbalance View Itch v3.0.2017'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs_USEquities

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
            'message_type::reg_sho_restriction_message': reg_sho_restriction_message
            'message_type::noii_message': noii_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::ipo_quoting_period_update_message': ipo_quoting_period_update_message
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
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Codes'
  stock_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For NASDAQ-listed issues, this field indicates when a firm is not in compliance with NASDAQ continued listing requirements'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if NASDAQ system limits order entry for issue'
      - id: issue_classification
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security class for the issue as assigned by NASDAQ. See Appendix for allowable values'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by NASDAQ. See Appendix for allowable values'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set-up in NASDAQ systems in a live/production, test, or demo state. Please note that firms should only show live issues and quoting participants on public quotation displays'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the NASDAQ security is set up for IPO release. This field is intended to help NASDAQ market participant firms comply with FINRA Rule 5131(b)'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Indicates which Limit Up / Limit Down price band calculation parameter is to be used for the instrument'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates whether the security is an exchange traded product (ETP):'
      - id: etp_leverage_factor
        type: u4
        doc: 'Tracks the integral relationship of the ETP to the underlying index. Example: If the underlying Index increases by a value of 1 and the ETP’s Leverage factor is 3, indicates the ETF will increase/decrease (see Inverse) by 3. Note: Leverage Factor of 1 indicates the ETP is NOT leveraged. This field is used for LULD Tier I price band calculation purposes'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index. Example: An ETP Leverage Factor of 3 and an Inverse value of ‘Y’ indicates the ETP will decrease by a value of 3'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the issue'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reflects the Market Ops or MarketWatch code for the trading state change'
  reg_sho_restriction_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
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
  noii_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: paired_shares
        type: u8
        doc: 'Indicates the total number of shares that are eligible to be matched at the Current Reference Price'
      - id: imbalance_shares
        type: u8
        doc: 'Number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
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
        doc: 'Indicates price at which the NOII shares are being calculated. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Denotes the type of Nasdaq cross for which the NOII message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'This field indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'
  cross_trade_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: shares
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
        doc: 'The price at which the cross occurred. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The Nasdaq generated day-unique Match Number of this execution'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Denotes the type of Nasdaq cross for which the NOII message is being generated'
  ipo_quoting_period_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the system event was generated. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the IPO release time for quotation to the nearest second. Format: HHMMSS'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'IPO Quotation Release Qualifier Code'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'Denotes the IPO price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
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
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates stock directory messages for all active symbols in the Nasdaq execution system.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'NASDAQ processes orders based on the most Reg SHO Restriction status value.'
    0x49:
      id: 'noii_message'
      doc: 'Nasdaq disseminates NOII data at 5-second intervals in the minutes leading up to the Nasdaq Opening and Closing Crosses as well as the IPO/Halt Crosses'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that Nasdaq has completed its cross process for a specific security. Nasdaq sends out a Cross Trade message for all active issues in the system following the Opening, Closing and EMC cross events. Firms may use the Cross Trade message to determine when the cross for each security has been completed.'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages This Is Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x58:
      id: 'clear_noii_opening_cross_data'
      doc: 'Clear Noii Opening Cross Data This Message Signals That Firms May Clear Noii Cache For The Regular Opening Cross'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
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
      id: 'nyse_mkt'
      doc: 'New York Stock Exchange Market'
    0x50:
      id: 'nyse_arca'
      doc: 'New York Stock Exchange Arca'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x20:
      id: 'na'
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
      id: 'na'
      doc: 'Not Available Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq System Only Accepts Round Lots Orders For This Security'
    0x4e:
      id: 'no_restrictions'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security Odd And Mixed Lot Orders Are Allowed'
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
      id: 'na'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
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
      id: 'not_applicable'
      doc: 'Not Applicable'
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
  current_trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasda Qlisted Securities Only'
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
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'closing_cross'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'cross_halted_or_paused'
      doc: 'Intraday Opening Cross For Ipo And Halted Paused Securities'
  price_variation_indicator:
    0x4c:
      id: 'less'
      doc: 'Less Than 1'
    0x31:
      id: 'value_x31'
      doc: '1 To 199'
    0x32:
      id: 'value_x32'
      doc: '2 To 299'
    0x33:
      id: 'value_x33'
      doc: '3 To 399'
    0x34:
      id: 'value_x34'
      doc: '4 To 499'
    0x35:
      id: 'value_x35'
      doc: '5 To 599'
    0x36:
      id: 'value_x36'
      doc: '6 To 699'
    0x37:
      id: 'value_x37'
      doc: '7 To 799'
    0x38:
      id: 'value_x38'
      doc: '8 To 899'
    0x39:
      id: 'value_x39'
      doc: '9 To 999'
    0x41:
      id: 'value_x41'
      doc: '10 To 1999'
    0x42:
      id: 'value_x42'
      doc: '20 To 2999'
    0x43:
      id: 'value_x43'
      doc: '30 Or Greater'
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated_quotation_release_time'
      doc: 'This Value Would Be Used When Nasdaq Market Operations Initially Enters The Ipo Instrument For Release'
    0x43:
      id: 'ipo_release_canceled_or_postponed'
      doc: 'This Value Would Be Used When Nasdaq Market Operations Cancels Or Postpones The Release Of The New Ipo Instrument'

