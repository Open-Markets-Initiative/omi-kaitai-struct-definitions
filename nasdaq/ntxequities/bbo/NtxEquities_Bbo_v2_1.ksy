# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxEquities Bbo Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TX Best Bid And Offer
#   Encoding: Itch
#   Version: 2.1
#   Date: 8/2/2024
#   Specification: NQ_QBBO_Specification__1_.pdf
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
  id: nasdaq_ntxequities_bbo_itch_v2_1
  title: Nasdaq NtxEquities Bbo Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas TX Best Bid And Offer Itch v2.1'
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
            'message_type::reg_sho_restriction_message': reg_sho_restriction_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_breach_message': mwcb_breach_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::bbo_quotation_message': bbo_quotation_message
            'message_type::price_improvement_message': price_improvement_message
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
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
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
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
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
        doc: 'Indicates the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issue as assigned by Nasdaq. See Appendix for allowable values'
      - id: issue_subtype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by Nasdaq. See Appendix for allowable values'
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
        doc: 'Indicates if the Nasdaq security is set up for IPO release'
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
        doc: 'Tracks the integral relationship of the ETP to the underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
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
  reg_sho_restriction_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  mwcb_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
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
  mwcb_breach_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  operational_halt_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Identifies the applicable Nasdaq market center'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Denotes the operational halt action'
  bbo_quotation_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: best_bid_price
        type: decimal_u4_4
        doc: 'Denotes the best bid price, or the highest price for market buy order(s) in the execution system. Implied decimal with scale 1e-4'
      - id: best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the execution system at the best bid price'
      - id: best_offer_price
        type: decimal_u4_4
        doc: 'Denotes the Nasdaq exchange''s best offer price, or the lowest price for market sell order(s) in the execution system. Implied decimal with scale 1e-4'
      - id: best_offer_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the execution system at the best offer price'
  price_improvement_message:
    seq:
      - id: tracking
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: interest_flag
        type: u1
        enum: interest_flag
        doc: 'Indicates the type of price improvement available'
  ipo_quoting_period_update_message:
    seq:
      - id: tracking
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Time stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the IPO release time, in seconds since midnight, for quotation to the nearest second'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'Denotes the IPO release qualifier'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'Denotes the IPO price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
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
      doc: 'The System Event message is used to signal key market or data feed control events.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates stock directory messages for all active symbols in its market center system.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Nasdaq introduced the Reg SHO Short Sale Price Test Restricted Indicator message format.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_breach_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x68:
      id: 'operational_halt_message'
      doc: 'The Exchange uses this message to indicate the current Operational Status of a security to the trading community.'
    0x51:
      id: 'bbo_quotation_message'
      doc: 'BBO products will broadcast a real-time update every time that the exchange''s best bid and offer quote is updated during the trading day.'
    0x4e:
      id: 'price_improvement_message'
      doc: 'Indicates a retail interest indication of the Bid, Ask or both the Bid and Ask for Nasdaq-listed securities.'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes that BBO feed has started its daily transmission schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that the exchange is open and ready to start accepting orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are available for execution.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are no longer available for execution.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It indicates that the exchange is now closed and will not accept any new orders today.'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes that BBO feed has completed its daily transmission schedule.'
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
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange (NYSE)'
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x5a:
      id: 'bats_bzx_exchange'
      doc: 'BATS BZX Exchange'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors'' Exchange, LLC'
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
      doc: 'Deficient and Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient and Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent and Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient, Delinquent and Bankrupt'
    0x43:
      id: 'creations_andor_redemptions_suspended'
      doc: 'Creations and/or Redemptions Suspended for Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Normal (Default): Issuer Is NOT Deficient, Delinquent, or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Company is in compliance, if Nasdaq-listed issue'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'only round lots are accepted in this stock'
    0x4e:
      id: 'no_restrictions'
      doc: 'odd/mixed lots are allowed'
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
      doc: 'Sec 144A'
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
      doc: 'Shares of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_benif_int'
      doc: 'Units/Benif Int'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live/Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue is restricted under SEC Rule 203(b)(3)'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue is not restricted'
    0x20:
      id: 'not_available'
      doc: 'Threshold Indicator not available'
  ipo_flag:
    0x59:
      id: 'ipo_security'
      doc: 'Nasdaq listed instrument is set up as a new IPO security'
    0x4e:
      id: 'not_ipo_security'
      doc: 'Nasdaq listed instrument is not set up as a new IPO security'
    0x20:
      id: 'not_available'
      doc: 'Not available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1_nms_stocks_and_select_et_ps'
      doc: 'Tier 1 NMS Stocks and select ETPs'
    0x32:
      id: 'tier_2_nms_stocks'
      doc: 'Tier 2 NMS Stocks'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument is an ETP'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument is not an ETP'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'ETP is an Inverse ETP'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'ETP is not an Inverse ETP'
  security_class:
    0x51:
      id: 'nasdaq_listed_issue'
      doc: 'Nasdaq-Listed Issue'
    0x4e:
      id: 'nyse'
      doc: 'NYSE'
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x5a:
      id: 'bats'
      doc: 'BATS'
    0x56:
      id: 'iexg'
      doc: 'IEXG'
  current_trading_state:
    0x48:
      id: 'halted_paused'
      doc: 'Halted/Paused on Nasdaq and all UTP participants'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x50:
      id: 'paused'
      doc: 'Paused across all U.S. equity markets / SROs (Nasdaq-listed securities only)'
    0x54:
      id: 'trading'
      doc: 'Trading on Nasdaq Market'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No price test in place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction in effect due to an intraday price drop in security'
    0x32:
      id: 'restriction_remains'
      doc: 'Reg SHO Short Sale Price Test Restriction remains in effect'
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
      doc: 'BX'
    0x58:
      id: 'psx'
      doc: 'PSX'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted on the identified Market'
    0x54:
      id: 'resumed'
      doc: 'Operational Halt has been lifted and Trading resumed'
  interest_flag:
    0x42:
      id: 'buy_side'
      doc: 'PI orders available on the buy side'
    0x53:
      id: 'sell_side'
      doc: 'PI orders available on the sell side'
    0x41:
      id: 'both_sides'
      doc: 'PI orders available on both sides (buy and sell)'
    0x4e:
      id: 'no_pi_available'
      doc: 'No PI orders available'
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated_quotation_release_time'
      doc: 'This value would be used when Nasdaq Market Operations initially enters the IPO instrument for release.'
    0x43:
      id: 'ipo_release_canceled_postponed'
      doc: 'This value would be used when Nasdaq Market Operations cancels or postpones the release of the IPO instrument.'

