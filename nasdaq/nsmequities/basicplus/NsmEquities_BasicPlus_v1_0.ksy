# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities BasicPlus Itch v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Basic Plus
#   Encoding: Itch
#   Version: 1.0
#   Date: 5/29/2026
#   Specification: Nasdaq Basic Plus_vF.pdf
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
  id: nasdaq_nsmequities_basicplus_itch_v1_0
  title: Nasdaq NsmEquities BasicPlus Itch v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Basic Plus Itch v1.0'
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
            'message_type::consolidated_quotation_message': consolidated_quotation_message
            'message_type::retail_price_improvement_message': retail_price_improvement_message
            'message_type::trading_action_message': trading_action_message
            'message_type::reg_sho_restriction_message': reg_sho_restriction_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_message': mwcb_status_message
            'message_type::ipo_quoting_period_update': ipo_quoting_period_update
            'message_type::operational_halt_message': operational_halt_message
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
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the type of system event for which the message is being generated'
  consolidated_quotation_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: best_bid_price
        type: decimal_u8_6
        doc: 'Denotes the best bid price, or the highest price for market buy order(s) in the execution system. Implied decimal with scale 1e-6'
      - id: best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the execution system at the best bid price'
      - id: best_offer_price
        type: decimal_u8_6
        doc: 'Denotes the Nasdaq exchange''s best offer price, or the lowest price for market sell order(s) in the execution system. Implied decimal with scale 1e-6'
      - id: best_offer_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the execution system at the best offer price'
      - id: best_bid_exchanges
        type: u1
        enum: best_bid_exchanges
        doc: 'The Exchange(s) the best bid information is relative to (Appendix E)'
      - id: best_offer_exchanges
        type: u1
        enum: best_offer_exchanges
        doc: 'The Exchange(s) the best offer information is relative to (Appendix E)'
  retail_price_improvement_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: buy_side_rpi_exchanges
        type: u1
        enum: buy_side_rpi_exchanges
        doc: 'The Exchange(s) of buy-side RPI the information is relative to (Appendix E)'
      - id: sell_side_rpi_exchanges
        type: u1
        enum: sell_side_rpi_exchanges
        doc: 'The Exchange(s) of sell-side RPI the information is relative to (Appendix E)'
  trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Reflects the current trading state for the issue'
      - id: reason_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reflects the Market Ops or Market Watch code for the trading state change'
  reg_sho_restriction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
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
  stock_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Listing Market / Category: indicates listing market or listing market tier for the issue'
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
        doc: 'Tracks the integral relationship of the ETP to the underlying index. Leverage Factor is rounded to the nearest integer below'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index'
  mwcb_decline_level_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
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
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  ipo_quoting_period_update:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: ipo_quotation_release_time
        type: second_timestamp
        doc: 'Denotes the IPO release time, in seconds since Epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'IPO quotation release qualifier'
      - id: ipo_price
        type: decimal_u8_6
        doc: 'Denotes the IPO price to be used for intraday net change calculations. Implied decimal with scale 1e-6'
  operational_halt_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp represented in nanoseconds since Epoch 1/1/1970, 00:00:00 UTC. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'The Market Center the Operational Halt is in effect for'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Operational halt action'
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
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages is used to signal key market or data feed control events.'
    0x51:
      id: 'consolidated_quotation_message'
      doc: 'Consolidated BBO will broadcast a real-time update every time the Consolidated BBO across Nasdaq owned and operated exchanges is updated throughout the trading day.'
    0x4e:
      id: 'retail_price_improvement_message'
      doc: 'Indicates a retail interest indication of the Bid, Ask or both the Bid and Ask for Nasdaq-listed securities. Populated for the Nasdaq Texas market only.'
    0x48:
      id: 'trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community. The message originates from the Nasdaq market center system.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Reg SHO Short Sale Price Test Restricted Indicator. Sends updates for the Nasdaq market only.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates stock directory messages for all active Nasdaq and non Nasdaq listed security symbols. The Stock Directory can be sent again during the trading day if any value changes.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels.'
    0x4b:
      id: 'ipo_quoting_period_update'
      doc: 'Indicates the anticipated IPO quotation release time of a security. Populated for the Nasdaq market only.'
    0x68:
      id: 'operational_halt_message'
      doc: 'The Exchange uses this message to indicate the current Operational Status of a security to the trading community, for the three market centers operated by Nasdaq.'
  event_code:
    0x4f:
      id: 'start_of_consolidated_market_transmissions'
      doc: 'Denotes That The Consolidated Systems Have Started The Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'The Consolidated Trading Session Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_regular_market_hours'
      doc: 'Denotes The Start Of The Regular Us Market Session'
    0x4d:
      id: 'end_of_regular_market_hours'
      doc: 'Denotes The End Of The Regular Us Session'
    0x45:
      id: 'end_of_system_hours'
      doc: 'The Consolidated Sessions Is Now Closed And Will Not Accept Any New Orders For The Trading Day'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That The Consolidated System Has Ended Its Daily Transmission Schedule'
  best_bid_exchanges:
    1:
      id: 'nasdaq'
      doc: 'Nasdaq Exchange'
    2:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas Exchange'
    3:
      id: 'nasdaq_and_nasdaq_texas'
      doc: 'Nasdaq Nasdaq Texas Exchanges'
    4:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx Exchange'
    5:
      id: 'nasdaq_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Psx Exchanges'
    6:
      id: 'nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Texas Nasdaq Psx Exchanges'
    7:
      id: 'nasdaq_nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Texas Nasdaq Psx Exchanges'
  best_offer_exchanges:
    1:
      id: 'nasdaq'
      doc: 'Nasdaq Exchange'
    2:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas Exchange'
    3:
      id: 'nasdaq_and_nasdaq_texas'
      doc: 'Nasdaq Nasdaq Texas Exchanges'
    4:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx Exchange'
    5:
      id: 'nasdaq_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Psx Exchanges'
    6:
      id: 'nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Texas Nasdaq Psx Exchanges'
    7:
      id: 'nasdaq_nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Texas Nasdaq Psx Exchanges'
  buy_side_rpi_exchanges:
    1:
      id: 'nasdaq'
      doc: 'Nasdaq Exchange'
    2:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas Exchange'
    3:
      id: 'nasdaq_and_nasdaq_texas'
      doc: 'Nasdaq Nasdaq Texas Exchanges'
    4:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx Exchange'
    5:
      id: 'nasdaq_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Psx Exchanges'
    6:
      id: 'nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Texas Nasdaq Psx Exchanges'
    7:
      id: 'nasdaq_nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Texas Nasdaq Psx Exchanges'
  sell_side_rpi_exchanges:
    1:
      id: 'nasdaq'
      doc: 'Nasdaq Exchange'
    2:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas Exchange'
    3:
      id: 'nasdaq_and_nasdaq_texas'
      doc: 'Nasdaq Nasdaq Texas Exchanges'
    4:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx Exchange'
    5:
      id: 'nasdaq_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Psx Exchanges'
    6:
      id: 'nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Texas Nasdaq Psx Exchanges'
    7:
      id: 'nasdaq_nasdaq_texas_and_nasdaq_psx'
      doc: 'Nasdaq Nasdaq Texas Nasdaq Psx Exchanges'
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

