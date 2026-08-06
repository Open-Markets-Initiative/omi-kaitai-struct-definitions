# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities NoiView Itch v3.0.2026
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Net Order Imbalance View
#   Encoding: Itch
#   Version: 3.0.2026
#   Date: 1/12/2026
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
  id: nsmequities_noiview_v3_0_2026
  title: Nasdaq NsmEquities NoiView Itch v3.0.2026
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Net Order Imbalance View Itch v3.0.2026'
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
            'message_type::system_event': system_event
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::ipo_quoting_period_update_message': ipo_quoting_period_update_message
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
  system_event:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: event_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'System Event Code identifier'
  stock_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_integer_6
        type: nanosecond_timestamp
        doc: 'Time Stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Nasdaq-listed compliance status'
      - id: round_lot_size
        type: u4
        doc: 'Number of shares in a round lot'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if system limits order entry to round lots'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Security class assigned by Nasdaq'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security sub-type assigned by Nasdaq'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Live/production, test, or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Subject to mandatory close-out under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if security is set up for IPO release'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Limit Up / Limit Down price band calculation parameter'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates if security is an exchange traded product'
      - id: etp_leverage_factor
        type: u4
        doc: 'Integral relationship of ETP to underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Directional relationship between ETP and underlying index'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Current trading state for the issue'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Ops or MarketWatch code for trading state change'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO restriction status at time of dissemination'
  net_order_imbalance_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: paired_shares
        type: u8
        doc: 'Total shares eligible to match at Current Reference Price'
      - id: imbalance_shares
        type: u8
        doc: 'Shares not paired at Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Market side of the imbalance'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: far_price
        type: decimal_u4_4
        doc: 'Hypothetical clearing price for cross orders only. Implied decimal with scale 1e-4'
      - id: near_price
        type: decimal_u4_4
        doc: 'Hypothetical clearing price for cross and continuous orders. Implied decimal with scale 1e-4'
      - id: current_reference_price
        type: decimal_u4_4
        doc: 'Price at which NOII shares are calculated. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type of Nasdaq cross'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'Deviation percentage of Near Indicative Clearing Price to Current Reference Price'
  cross_trade_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: shares
        type: u8
        doc: 'Number of shares matched in the Nasdaq Cross'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: cross_price
        type: decimal_u4_4
        doc: 'Price at which the cross occurred. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'Nasdaq generated day-unique match number'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type of Nasdaq cross'
  ipo_quoting_period_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_timestamp_6
        type: nanosecond_timestamp
        doc: 'Time of system event generation. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'IPO release time for quotation in HHMMSS format'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'Indicates anticipated release or cancellation/postponement'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'IPO price for intraday net change calculations. Implied decimal with scale 1e-4'
  direct_listing_with_capital_raise_price_discovery_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp_integer_6
        type: nanosecond_timestamp
        doc: 'Time Stamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: open_eligibility_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if security is eligible for trading release'
      - id: minimum_allowable_price
        type: decimal_u4_4
        doc: '20% below Registration Statement Lower Price. Implied decimal with scale 1e-4'
      - id: maximum_allowable_price
        type: decimal_u4_4
        doc: '80% above Registration Statement Highest Price. Implied decimal with scale 1e-4'
      - id: near_execution_price
        type: decimal_u4_4
        doc: 'Reference price when DLCR volatility test has passed. Implied decimal with scale 1e-4'
      - id: near_execution_time
        type: u8
        doc: 'Time at which near execution price was set'
      - id: lower_price_range_collar
        type: decimal_u4_4
        doc: 'Lower Auction Collar Threshold (10% below Near Execution Price). Implied decimal with scale 1e-4'
      - id: upper_price_range_collar
        type: decimal_u4_4
        doc: 'Upper Auction Collar Threshold (10% above Near Execution Price). Implied decimal with scale 1e-4'
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
      id: 'system_event'
      doc: 'Signals a market or data feed handler event'
    0x52:
      id: 'stock_directory_message'
      doc: 'Disseminates stock directory info for all active symbols at start of trading day'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Indicates the current trading status of a security'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Indicates Rule 201 Reg SHO restriction status for a security'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'Net Order Imbalance Indicator for Opening, Closing, and Extended Trading crosses'
    0x51:
      id: 'cross_trade_message'
      doc: 'Indicates Nasdaq has completed its cross process for a specific security'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security'
    0x4f:
      id: 'direct_listing_with_capital_raise_price_discovery_message'
      doc: 'Disseminated for DLCR securities once volatility test has passed'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market_sm'
      doc: 'Nasdaq Global Select Market Sm'
    0x47:
      id: 'nasdaq_global_market_sm'
      doc: 'Nasdaq Global Market Sm'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'new_york_stock_exchange_nyse'
      doc: 'New York Stock Exchange Nyse'
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
      id: 'bats_z_exchange'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
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
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Non Nasdaqlisted Refer To Siac Feeds'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'System Only Accepts Round Lot Orders'
    0x4e:
      id: 'no_restriction'
      doc: 'Odd And Mixed Lot Orders Allowed'
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
      id: 'value_x49'
      doc: '144 A'
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
      doc: 'Not Restricted'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  ipo_flag:
    0x59:
      id: 'ipo_security'
      doc: 'Nasdaqlisted Instrument Set Up As New Ipo'
    0x4e:
      id: 'not_ipo_security'
      doc: 'Nasdaqlisted Instrument Not Set Up As New Ipo'
    0x5a:
      id: 'non_ipo_new_listed_security'
      doc: 'Non Ipo New Listed Security'
    0x20:
      id: 'not_available'
      doc: 'Non Nasdaqlisted Instruments'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1_nms_stocks_and_select_et_ps'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2_nms_stocks'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Not Etp'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Not Inverse Etp'
  current_trading_state:
    0x48:
      id: 'halted_across_all_us_equity_markets_sr_os'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused_across_all_us_equity_markets_sr_os'
      doc: 'Nasdaqlisted Securities Only'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading_on_nasdaq'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Due To Intraday Price Drop In Security'
    0x32:
      id: 'restriction_remains_in_effect'
      doc: 'Restriction Remains In Effect'
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
      id: 'insufficient_orders_to_calculate'
      doc: 'Insufficient Orders To Calculate'
    0x50:
      id: 'paused'
      doc: 'Paused'
  cross_type:
    0x4f:
      id: 'open_cross'
      doc: 'Open Cross'
    0x43:
      id: 'close_cross'
      doc: 'Close Cross'
    0x48:
      id: 'intraday_opening_cross_for_ipo_and_halted_paused_securities'
      doc: 'Intraday Opening Cross For Ipo And Halted Paused Securities'
    0x41:
      id: 'extended_trading_close'
      doc: 'Extended Trading Close'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1'
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
    0x20:
      id: 'cannot_be_calculated'
      doc: 'Cannot Be Calculated'
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated_quotation_release_time'
      doc: 'Anticipated Quotation Release Time'
    0x43:
      id: 'ipo_release_canceledpostponed'
      doc: 'Ipo Release Canceledpostponed'

