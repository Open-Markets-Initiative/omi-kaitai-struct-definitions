# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities Bbo Itch v2.1.2018
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Best Bid And Offer
#   Encoding: Itch
#   Version: 2.1.2018
#   Date: 05/03/2018
#   Specification: PSXbboSpecification2.1.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: psxequities_bbo_v2_1_2018
  title: Nasdaq PsxEquities Bbo Itch v2.1.2018
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX Best Bid And Offer Itch v2.1.2018'
doc-ref: http://nasdaqtrader.com/content/technicalsupport/specifications/dataproducts/PSXbboSpecification2.1.pdf

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
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_message': mwcb_status_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::quotation_message': quotation_message
            'message_type::next_shares_quotation_message': next_shares_quotation_message
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
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the type of event for which the message is being generated'
  stock_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
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
        doc: 'Indicates whether the security is an exchange traded product (ETP)'
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
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
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
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
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
  mwcb_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: level_1
        type: u8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: u8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: u8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  mwcb_status_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  operational_halt_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
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
        doc: 'Market code'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the price of the Upper Auction Collar Threshold'
  quotation_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: psx_best_bid_price
        type: u4
        doc: 'The highest price for market buy order(s) in the PSX system. Implied decimal with scale 1e-4'
      - id: psx_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX best bid Price'
      - id: psx_best_offer_price
        type: u4
        doc: 'The lowest price for market sell order(s) in the PSX system. Implied decimal with scale 1e-4'
      - id: psx_best_offer_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX best Offer Price'
  next_shares_quotation_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'NASDAQ internal tracking number'
      - id: timestamp
        size: 6
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: next_shares_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NextShares symbol in the Nasdaq execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: nasdaq_best_bid
        type: u4
        doc: 'Denotes the Nasdaq best bid. Implied decimal with scale 1e-4'

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'Used to signal key market or data feed control events'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data vendors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for Nasdaq-listed issues.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Nasdaq processes orders based on the most Reg SHO Restriction status value.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x68:
      id: 'operational_halt_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of the three market centers operated by Nasdaq.'
    0x51:
      id: 'quotation_message'
      doc: 'PSX BBO will broadcast a real-time update every time that the exchange’s best bid and offer quote is updated during the trading day.'
    0x41:
      id: 'next_shares_quotation_message'
      doc: 'This version of the Quotation message format will be used for Exchange Traded Managed Funds (NextShares). For this asset class, Nasdaq will support both Proxy Price and Net Asset Value (NAV) premium/discount amount for the best bid and offer.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That Psx Bbo Has Started Its Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Psx Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Psx Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_messages'
      doc: 'Denotes That Psx Bbo Has Completed Its Daily Transmission Schedule'
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
      id: 'nyse_amex'
      doc: 'New York Stock Exchange Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'New York Stock Exchange Arca'
    0x5a:
      id: 'bats_bzx'
      doc: 'Bats Bzx Exchange'
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
      doc: 'Only Round Lots Are Accepted In This Stock'
    0x4e:
      id: 'odd_mixed_allowed'
      doc: 'Oddmixed Lots Are Allowed'
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
      id: 'nasdaq_listed_instrument'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'nasdaq_listed_instrument_x4e'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x20:
      id: 'na'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'na'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'na'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  security_class:
    0x51:
      id: 'nasdaq_listed_issue'
      doc: 'Nasdaq Listed Issue'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'nyse_mkt'
      doc: 'New York Stock Exchange Mkt'
    0x50:
      id: 'nyse_arca'
      doc: 'New York Stock Exchange Arca'
    0x5a:
      id: 'bats'
      doc: 'Bats Exchange'
    0x56:
      id: 'iexg'
      doc: 'Investors Exchange'
    0x20:
      id: 'na'
      doc: 'Not Available'
  current_trading_state:
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
      doc: 'Trading On Nasdaq Psx'
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
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'bx'
      doc: 'Bx'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'

