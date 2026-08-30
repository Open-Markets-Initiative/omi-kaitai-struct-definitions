# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Level2 Itch v2.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Level 2
#   Encoding: Itch
#   Version: 2.0
#   Date: 2/19/2026
#   Specification: Level2Specification.pdf
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
  id: nasdaq_nsmequities_level2_itch_v2_0
  title: Nasdaq NsmEquities Level2 Itch v2.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Level 2 Itch v2.0'
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
            'message_type::market_participant_position_message': market_participant_position_message
            'message_type::operational_halt_message': operational_halt_message
            'message_type::market_participant_bid_ask_update_message': market_participant_bid_ask_update_message
            'message_type::retail_price_interest_indicator_message': retail_price_interest_indicator_message
            'message_type::market_wide_circuit_breaker_decline_level_message': market_wide_circuit_breaker_decline_level_message
            'message_type::market_wide_circuit_breaker_status_message': market_wide_circuit_breaker_status_message
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
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  stock_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
        doc: 'Indicates the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issue as assigned by Nasdaq'
      - id: issue_subtype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by Nasdaq'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set up in Nasdaq systems in a live/production, test, or demo state'
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
        doc: 'Indicates the directional relationship between the ETP and underlying index'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reflects the Market Ops or Market Watch code for the trading state change'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
  operational_halt_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
  market_participant_bid_ask_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'Denotes the side of the market associated with the price level update'
      - id: participant_shares
        type: u4
        doc: 'Reflects the current number of shares displayed by this participant at this price level'
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
  retail_price_interest_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
  market_wide_circuit_breaker_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
      - id: level_1
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
        doc: 'Time at which the Operational Halt message was generated. Nanoseconds since Midnight epoch'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0

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
    0x68:
      id: 'operational_halt_message'
      doc: 'Indicates the current Operational Status of a security specific to the designated Market Center'
    0x55:
      id: 'market_participant_bid_ask_update_message'
      doc: 'Provides top-of-file bid/ask updates for each registered Nasdaq market participant'
    0x4e:
      id: 'retail_price_interest_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both for Nasdaq-listed securities'
    0x56:
      id: 'market_wide_circuit_breaker_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day'
    0x57:
      id: 'market_wide_circuit_breaker_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Indicates That Market Hours Orders Are Available For Execution'
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
      id: 'bats_bzx_exchange'
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
      id: 'in_compliance'
      doc: 'Company Is In Compliance If Nasdaqlisted Issue'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Only Round Lots Are Accepted In This Stock'
    0x4e:
      id: 'no_restriction'
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
      id: 'ipo_security'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_ipo'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x5a:
      id: 'non_ipo_new_listed'
      doc: 'Nasdaq Listed Instrument Is A Non Ipo New Listed Security'
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
  current_trading_state:
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
      id: 'bid_update'
      doc: 'Bid Update'
    0x53:
      id: 'offer_ask_update'
      doc: 'Offerask Update'
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
      doc: 'Used When Nasdaq Market Operations Cancels Or Postpones The Release Of The Ipo Instrument'

