# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities Bbo Itch v2.1.2017
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Best Bid And Offer
#   Encoding: Itch
#   Version: 2.1.2017
#   Date: 09/12/2017
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
  id: nasdaq_psxequities_bbo_itch_v2_1_2017
  title: Nasdaq PsxEquities Bbo Itch v2.1.2017
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX Best Bid And Offer Itch v2.1.2017'
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
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_message': mwcb_status_message
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
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the type of event for which the message is being generated'
  stock_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
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
        doc: 'For Nasdaq-listed issues, this field indicates when a firm is not in compliance with Nasdaq continued listing requirements'
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
        doc: 'Denotes if an issue or quoting participant record is set-up in Nasdaq systems in a live/production, test, or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the Nasdaq security is set up for IPO release. This field is intended to help Nasdaq market participant firms comply with FINRA Rule 5131(b)'
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
        doc: 'Tracks the integral relationship of the ETP to the underlying index. Note: Leverage Factor of 1 indicates the ETP is NOT leveraged'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index. This field is used for LULD Tier I price band calculation purposes'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
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
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  mwcb_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
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
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  quotation_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: psx_best_bid_price
        type: decimal_u4_4
        doc: 'Denotes the PSX best bid price, the highest price for market buy order(s) in the PSX system. Implied decimal with scale 1e-4'
      - id: psx_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX best bid Price'
      - id: psx_best_offer_price
        type: decimal_u4_4
        doc: 'Denotes the PSX exchange''s best offer price, the lowest price for market sell order(s) in the PSX system. Implied decimal with scale 1e-4'
      - id: psx_best_offer_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX Best Offer Price'
  next_shares_quotation_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
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
      - id: nasdaq_best_bid_proxy_price
        type: decimal_u4_4
        doc: 'Denotes the Nasdaq best bid price for NextShares in proxy price format. Implied decimal with scale 1e-4'
      - id: nasdaq_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq market center system at the Nasdaq best bid price'
      - id: nasdaq_best_bid_nav_premium_discount_amount
        type: decimal_s4_4
        doc: 'Denotes premium or discount amount to the NAV reflected in the Nasdaq best bid. Please note: This is a signed (+/-) field. Implied decimal with scale 1e-4'
      - id: nasdaq_best_offer_proxy_price
        type: decimal_u4_4
        doc: 'Denotes the Nasdaq best offer for the NextShares in proxy price format. Implied decimal with scale 1e-4'
      - id: nasdaq_best_offer_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq market center system at the Nasdaq best offer price'
      - id: nasdaq_best_offer_nav_premium_discount_amount
        type: decimal_s4_4
        doc: 'Denotes the premium or discount amount to the NAV reflected in the Nasdaq best offer. Please note: this is a signed (+/-) field. Implied decimal with scale 1e-4'
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The System Event message is used to signal key market or data feed control events.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Nasdaq PSX disseminates stock directory messages for all active symbols in its market center system.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Denotes the Reg SHO Short Sale Price Test Restriction (Rule 201) status for an issue: a full pre-opening spin for Nasdaq-listed issues and intraday status changes.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels.'
    0x51:
      id: 'quotation_message'
      doc: 'PSX BBO will broadcast a real-time update every time that the exchange''s best bid and offer quote is updated during the trading day.'
    0x41:
      id: 'next_shares_quotation_message'
      doc: 'This version of the Quotation message format will be used for Exchange Traded Managed Funds (NextShares). For this asset class, Nasdaq will support both Proxy Price and Net Asset Value (NAV) premium/discount amount for the best bid and offer. Not currently supported for the PSX market (grayed out in the specification).'
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
      id: 'end_of_transmissions'
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
      doc: 'New York Stock Exchange Nyse'
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x5a:
      id: 'bats_bzx_exchange'
      doc: 'Bats Bzx Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange Llc'
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
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'in_compliance'
      doc: 'Company Is In Compliance If Nasdaqlisted Issue'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Only Round Lots Are Accepted In This Stock'
    0x4e:
      id: 'odd_and_mixed_lots_allowed'
      doc: 'Oddmixed Lots Are Allowed'
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
      id: 'new_ipo_security'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_new_ipo_security'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x20:
      id: 'not_available'
      doc: 'Non Nasdaq Listed Instruments Not Available'
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
  security_class:
    0x51:
      id: 'nasdaq_listed_issue'
      doc: 'Nasdaq Listed Issue'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x41:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x56:
      id: 'iexg'
      doc: 'Investors Exchange Llc'
  current_trading_state:
    0x48:
      id: 'halted_or_paused_on_nasdaq_and_all_utp_participants'
      doc: 'Halted Paused On Nasdaq And All Utp Participants'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x50:
      id: 'paused_across_all_us_equity_markets'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasdaqlisted Securities Only'
    0x54:
      id: 'trading_on_psx'
      doc: 'Trading On Psx'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'restriction_remains_in_effect'
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

