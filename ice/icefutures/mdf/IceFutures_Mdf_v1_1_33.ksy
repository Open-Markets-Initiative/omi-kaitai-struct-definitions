# ---------------------------------------------------------------------
# Kaitai struct definition for: Ice IceFutures Mdf iMpact v1.1.33
#
# Protocol:
#   Organization: Intercontinental Exchange
#   Protocol: Multicast Data Feed
#   Encoding: Ice iMpact Binary Encoding
#   Version: 1.1.33
#   Date: 8/6/2018
#   Specification: ICE_iMpact_Multicast_Feed_Message_Spec_1.1.33.pdf
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
  id: ice_icefutures_mdf_impact_v1_1_33
  title: Ice IceFutures Mdf iMpact v1.1.33
  license: GPL-3.0
  endian: be

doc: 'Intercontinental Exchange Intercontinental Exchange Futures Multicast Data Feed iMpact v1.1.33'

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'iMpact Upd market data packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_of_msgs
    doc: 'iMpact message'

types:
  packet_header_struct:
    seq:
      - id: session
        type: u2
        doc: 'TODO'
      - id: sequence
        type: u4
        doc: 'TODO'
      - id: number_of_msgs
        type: u2
        doc: 'Field indicates the number of messages contained in the block'
      - id: sent_date_time
        type: millisecond_timestamp
        doc: 'Field is the timestamp of when the message block is sent, the number of milliseconds since Jan 1st, 1970, 00:00:00 GMT. Milliseconds since Unix epoch'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'iMpact message header'
      - id: payload
        size: message_header.length + 3 - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::market_snapshot_message': market_snapshot_message
            'message_type::trade_message': trade_message
            'message_type::spot_market_trade_message': spot_market_trade_message
            'message_type::investigated_trade_message': investigated_trade_message
            'message_type::cancelled_trade_message': cancelled_trade_message
            'message_type::market_statistics_message': market_statistics_message
            'message_type::market_state_change_message': market_state_change_message
            'message_type::system_text_message': system_text_message
            'message_type::open_interest_message': open_interest_message
            'message_type::open_price_message': open_price_message
            'message_type::close_price_message': close_price_message
            'message_type::settlement_price_message': settlement_price_message
            'message_type::index_prices_message': index_prices_message
            'message_type::end_of_day_market_summary_message': end_of_day_market_summary_message
            'message_type::market_event_message': market_event_message
            'message_type::pre_open_price_indicator_message': pre_open_price_indicator_message
            'message_type::strip_info_message': strip_info_message
            'message_type::interval_price_limit_notification_message': interval_price_limit_notification_message
            'message_type::new_futures_strategy_definition_message': new_futures_strategy_definition_message
            'message_type::new_expiry_message': new_expiry_message
            'message_type::special_field_message': special_field_message
            'message_type::market_snapshot_order_message': market_snapshot_order_message
            'message_type::add_or_modify_order_message': add_or_modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::message_bundle_marker': message_bundle_marker
            'message_type::fixing_transition_message': fixing_transition_message
            'message_type::fixing_lockdown_message': fixing_lockdown_message
            'message_type::fixing_indicative_price_message_message': fixing_indicative_price_message_message
            'message_type::market_snapshot_price_level_message': market_snapshot_price_level_message
            'message_type::add_price_level_message': add_price_level_message
            'message_type::change_price_level_message': change_price_level_message
            'message_type::delete_price_level_message': delete_price_level_message
            'message_type::new_options_strategy_definition_message': new_options_strategy_definition_message
            'message_type::new_options_market_definition_message': new_options_market_definition_message
            'message_type::rfq_message': rfq_message
            'message_type::option_open_interest_message': option_open_interest_message
            'message_type::option_settlement_price_message': option_settlement_price_message
            'message_type::old_style_options_trade_and_market_stats_message': old_style_options_trade_and_market_stats_message
      - id: extra_data
        size: 0
        doc: 'Message bytes past the fields this version decodes'
  message_header:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: length
        type: u2
        doc: 'Length of message'
  market_snapshot_message:
    seq:
      - id: market_id
        type: s4
      - id: market_type
        type: s2
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Appendix A on the trading status codes'
      - id: volume
        type: s4
        doc: 'Electronic trade volume only, excluding block and other volumes'
      - id: block_volume
        type: s4
      - id: efs_volume
        type: s4
      - id: efp_volume
        type: s4
      - id: open_interest
        type: s4
      - id: opening_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: settlement_price_with_deal_price_precision
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get this price'
      - id: high
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: low
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: vwap
        type: s8
        doc: 'Weighted Average Price. DealPriceDenominator for the market should be applied to get the real price'
      - id: num_of_book_entries
        type: s4
        doc: 'Number of book entries in the market. It is the number of order messages followed for full order depth snapshot channel. In case of price level snapshot, it is the number of price level messages that followed for the market'
      - id: last_trade_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: last_trade_quantity
        type: s4
      - id: last_trade_date_time
        type: millisecond_timestamp
        doc: 'time of last trade. Milliseconds since Unix epoch'
      - id: settle_price_date_time
        type: millisecond_timestamp
        doc: 'Settlement price time. Milliseconds since Unix epoch'
      - id: last_message_sequence_id
        type: s4
        doc: 'This should be used for synchronization with live update messages. Please see the main tech spec for details on how it can be done'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: open_interest_date
        type: iso_date
        doc: 'The date Open Interest is effective for'
      - id: is_settle_price_official
        type: u1
        enum: is_settle_price_official
        doc: 'Indicate if the SettlementPrice is official, ‘Y’ or ‘N’'
      - id: settlement_price
        type: s8
        doc: 'SettlePriceDenominator for the market should be applied to get the real settlement price'
      - id: has_previous_day_settlement_price
        type: u1
        enum: has_previous_day_settlement_price
        doc: 'Indicate if the PreviousSettlementDayPrice is populated, ‘Y’ or ‘N’'
      - id: previous_day_settlement_price
        type: s8
        doc: 'SettlePriceDenominator for the market should be applied to get the real previous day settlement price'
  trade_message:
    seq:
      - id: market_id
        type: s4
      - id: trade_id
        type: s8
        doc: 'Unique identifier of the trade message, unique per market'
      - id: is_system_priced_leg
        type: u1
        enum: is_system_priced_leg
        doc: 'Indicate if it is a system priced leg, ‘Y’ or ‘N’'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: off_market_trade_indicator
        type: u1
        enum: off_market_trade_indicator
        doc: 'Legacy field that supports all single character trade types on ICE. The new 3-character “OffMarketTradeType” field replaces this field. In the future (no earlier than 2015), ICE anticipates the introduction of 3 character trade types that will only be available in the new field. Trade types that are longer than a single character will be represented with “#” in this field'
      - id: transact_date_time
        type: millisecond_timestamp
        doc: 'Deal date time. Milliseconds since Unix epoch'
      - id: system_priced_leg_type
        type: u1
        enum: system_priced_leg_type
        doc: 'System Priced Leg Type'
      - id: is_implied_spread_at_market_open
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate if the trade happens at market open due to spread implied. When set to ‘Y’, such deal should not be included in market stats'
      - id: is_adjusted_trade
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate if the trade is an adjusted trade, ‘Y’ or ‘N’'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Aggressor Side'
      - id: extra_flags
        type: s1
        doc: 'Flags'
      - id: off_market_trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Only for off market trade. The first character is ‘ ‘ when it is a regular trade. One or two null characters (‘\0’) will be appended to the end of this field when applicable'
      - id: sequence_within_millis
        type: s4
        doc: 'Can be used in conjunction with TransactDateTime field for sequence of deals within same milliseconds time'
  spot_market_trade_message:
    seq:
      - id: market_id
        type: s4
      - id: trade_id
        type: s8
        doc: 'Unique identifier of the trade message, unique per market'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: transact_date_time
        type: millisecond_timestamp
        doc: 'Deal date time. Milliseconds since Unix epoch'
      - id: extra_flags
        type: s1
        doc: 'Flags'
      - id: delivery_begin_date_time
        type: millisecond_timestamp
        doc: 'Delivery begin date time. Milliseconds since Unix epoch'
      - id: delivery_end_date_time
        type: millisecond_timestamp
        doc: 'Delivery end date time. Milliseconds since Unix epoch'
      - id: is_system_priced_leg
        type: u1
        enum: is_system_priced_leg
        doc: 'Indicate if it is a system priced leg, ‘Y’ or ‘N’'
  investigated_trade_message:
    seq:
      - id: market_id
        type: s4
      - id: trade_id
        type: s8
        doc: 'Unique identifier of the trade message, unique per market'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: off_market_trade_indicator
        type: u1
        enum: off_market_trade_indicator
        doc: 'Legacy field that supports all single character trade types on ICE. The new 3-character “OffMarketTradeType” field replaces this field. In the future (no earlier than 2015), ICE anticipates the introduction of 3 character trade types that will only be available in the new field. Trade types that are longer than a single character will be represented with “#” in this field'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: investigation_status
        type: u1
        enum: investigation_status
        doc: '‘1’ – Under Investigation, ‘2’ – Investigation Completed'
      - id: off_market_trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Only for off market trade. The first character is ‘ ‘ when it is a regular trade. One or two null characters (‘\0’) will be appended to the end of this field when applicable'
  cancelled_trade_message:
    seq:
      - id: market_id
        type: s4
      - id: trade_id
        type: s8
        doc: 'Unique identifier of the trade message, unique per market'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: off_market_trade_indicator
        type: u1
        enum: off_market_trade_indicator
        doc: 'Legacy field that supports all single character trade types on ICE. The new 3-character “OffMarketTradeType” field replaces this field. In the future (no earlier than 2015), ICE anticipates the introduction of 3 character trade types that will only be available in the new field. Trade types that are longer than a single character will be represented with “#” in this field'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: off_market_trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Only for off market trade. The first character is ‘ ‘ when it is a regular trade. One or two null characters (‘\0’) will be appended to the end of this field when applicable'
  market_statistics_message:
    seq:
      - id: market_id
        type: s4
      - id: volume
        type: s4
        doc: 'Electronic trade volume only, excluding block and other volumes'
      - id: block_volume
        type: s4
      - id: efs_volume
        type: s4
      - id: efp_volume
        type: s4
      - id: high
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: low
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: vwap
        type: s8
        doc: 'Weighted Average Price. DealPriceDenominator for the market should be applied to get the real price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  market_state_change_message:
    seq:
      - id: market_id
        type: s4
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Appendix A on the trading status codes'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  system_text_message:
    seq:
      - id: text_message
        type: str
        size: 200
        encoding: ASCII
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: text_message_extra_fld
        type: str
        size: 800
        encoding: ASCII
        doc: 'Extra field for text message when TextMessage field is not big enough. This should be appended to TextMessage if it is not empty'
  open_interest_message:
    seq:
      - id: market_id
        type: s4
      - id: open_interest
        type: s4
      - id: open_interest_change
        type: s4
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: open_interest_date
        type: iso_date
        doc: 'The date Open Interest is effective for'
  open_price_message:
    seq:
      - id: market_id
        type: s4
      - id: open_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  close_price_message:
    seq:
      - id: market_id
        type: s4
      - id: close_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  settlement_price_message:
    seq:
      - id: market_id
        type: s4
      - id: settlement_price_with_deal_price_precision
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get this price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: is_official
        type: u1
        enum: is_official
        doc: 'Flag to indicate this is official settlement price or not'
      - id: valuation_date_time
        type: millisecond_timestamp
        doc: 'Date time the settlement price is for. Milliseconds since Unix epoch'
      - id: settlement_price
        type: s8
        doc: 'SettlePriceDenominator for the market should be applied to get the real settlement price'
  index_prices_message:
    seq:
      - id: market_id
        type: s4
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: short_name
        type: str
        size: 30
        encoding: ASCII
        doc: 'The short name date of the Marker/Index. For example “Morn5Min”'
      - id: published_date_time
        type: millisecond_timestamp
        doc: 'The date and time the marker was put into. Milliseconds since Unix epoch'
      - id: valuation_date_applying_date
        type: iso_date
        doc: 'The date this price is effective for'
      - id: status
        type: u1
        enum: status
        doc: 'For Endex Spot markets'
  end_of_day_market_summary_message:
    seq:
      - id: market_id
        type: s4
      - id: volume
        type: s4
        doc: 'Electronic trade volume only, excluding block and other volumes'
      - id: block_volume
        type: s4
      - id: efs_volume
        type: s4
      - id: efp_volume
        type: s4
      - id: opening_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: high
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: low
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: vwap
        type: s8
        doc: 'Weighted Average Price. DealPriceDenominator for the market should be applied to get the real price'
      - id: settlement_price_with_deal_price_precision
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get this price'
      - id: open_interest
        type: s4
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: settlement_price
        type: s8
        doc: 'SettlePriceDenominator for the market should be applied to get the real settlement price'
  market_event_message:
    seq:
      - id: market_id
        type: s4
      - id: event_type
        type: str
        size: 1
        encoding: ASCII
        doc: '‘A’ – Implication Disabled for the Market'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  pre_open_price_indicator_message:
    seq:
      - id: market_id
        type: s4
      - id: pre_open_price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: has_pre_open_volume
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates message contains PreOpenVolume. ‘Y’ or ‘N’'
      - id: pre_open_volume
        type: s4
        doc: 'Indicative volume that would trade at the preOpenPrice'
  strip_info_message:
    seq:
      - id: old_strip_id
        type: s2
        doc: 'Not used. Kept here for backward compatibility. Client should use the new 4-byte StripID field'
      - id: strip_type
        type: str
        size: 20
        encoding: ASCII
      - id: begin_year
        type: s2
        doc: '4 digit year'
      - id: begin_month
        type: s2
        doc: 'Month range 1-12'
      - id: begin_day
        type: s2
      - id: end_year
        type: s2
        doc: '4 digit year'
      - id: end_month
        type: s2
        doc: 'Month range 1-12'
      - id: end_day
        type: s2
      - id: strip_info
        type: str
        size: 50
        encoding: ASCII
      - id: strip_id
        type: s4
        doc: 'StripID'
  interval_price_limit_notification_message:
    seq:
      - id: market_id
        type: s4
      - id: ipl_hold_type
        type: u1
        enum: ipl_hold_type
        doc: 'IPL Hold Type: ‘S’ – IPL Hold Start, ‘E’ – IPL Hold End'
      - id: notification_date_time
        type: millisecond_timestamp
        doc: 'Date time of the IPL Hold notification. Milliseconds since Unix epoch'
      - id: is_up
        type: u1
        enum: is_up
        doc: '‘Y’ – IPL Upper bound violation (Bidding too high), ‘N’ – IPL Lower bound violation (Asking too low), N/A when IPLHoldType = ‘E’'
      - id: ipl_hold_duration
        type: s4
        doc: 'Hold duration, in milliseconds. N/A when IPLHoldNotifyType = ‘E’'
      - id: ipl_up
        type: s8
        doc: 'IPL upper bound. OrderPriceDenominator for the market should be applied to get the real price limit. N/A when IPLHoldNotifyType = ‘E’'
      - id: ipl_down
        type: s8
        doc: 'IPL lower bound. OrderPriceDenominator for the market should be applied to get the real price limit. >N/A when IPLHoldNotifyType = ‘E’'
  new_futures_strategy_definition_message:
    seq:
      - id: market_id
        type: s4
      - id: futures_contract_symbol
        type: str
        size: 70
        encoding: ASCII
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Appendix A on the trading status codes'
      - id: order_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the order price fields in this market'
      - id: increment_price
        type: s4
        doc: 'Minimum increment premium price for this market. OrderPriceDenominator should be applied to this field'
      - id: increment_qty
        type: s4
        doc: 'Minimum increment quantity for this market'
      - id: min_qty
        type: s4
        doc: 'Minimum quantity for this market'
      - id: num_leg_definition
        type: s1
        doc: 'Number of strategy leg definitions. The leg info'
      - id: leg_definition
        type: leg_definition
        repeat: expr
        repeat-expr: num_leg_definition
        doc: 'Leg Definition'
      - id: security_sub_type
        type: s2
        enum: security_sub_type
        doc: 'Contains the Strategy Code for defined market where applicable. See Appendix E for list of codes'
      - id: is_block_only
        type: u1
        enum: is_block_only
        doc: 'Indicates if Market is only tradable via ICE Block Trade. This also means the screen trading is not allowed for the market. ‘Y’ or ‘N’'
      - id: strategy_symbol
        type: str
        size: 18
        encoding: ASCII
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'Indicates if GTC is allowed in the market. ‘Y’ or ‘N’'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: mifid_regulated_market
        type: u1
        enum: mifid_regulated_market
        doc: 'Indicates MIFID-II market. ‘Y’ or ‘N’'
      - id: market_desc
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description of the market'
      - id: maturity_year
        type: s2
        doc: '4 digit year'
      - id: maturity_month
        type: s2
        doc: 'Month range 1-12'
      - id: maturity_day
        type: s2
      - id: deal_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the deal price fields in the market. For most markets, this is the same as OrderPriceDenominator. However, it could be different for some crack or spread markets'
      - id: unit_quantity
        type: s4
        doc: 'The quantity in unit of measurement per lot. For example, it is 1000 barrels per lot for Brent'
      - id: num_decimals_options_price
        type: str
        size: 1
        encoding: ASCII
        doc: 'Only used for OffExchangeIncrementOptionPrice'
      - id: allow_options
        type: u1
        enum: allow_options
        doc: 'Indicate if the market supports option markets, ‘Y’ or ‘N’'
      - id: cleared_alias
        type: str
        size: 15
        encoding: ASCII
        doc: 'Clearing limit admin related'
      - id: allows_implied
        type: u1
        enum: allows_implied
        doc: '‘Y’ indicates this is a spread market, and, implied is allowed in this market'
      - id: min_price
        type: s8
        doc: 'Minimum Price. OrderPriceDenominator should be applied to this field'
      - id: max_price
        type: s8
        doc: 'Maximum Price. OrderPriceDenominator should be applied to this field'
      - id: product_name
        type: str
        size: 62
        encoding: ASCII
        doc: 'Name of the product that the contract/market is under'
      - id: hub_alias
        type: str
        size: 80
        encoding: ASCII
        doc: 'Alias of the hub for the contract/market'
      - id: strip_name
        type: str
        size: 39
        encoding: ASCII
        doc: 'Name of the strip for the contract/market'
      - id: is_tradable
        type: u1
        enum: is_tradable
        doc: 'Indicate if the contract is tradable. ‘Y’ or ‘N’'
      - id: settle_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the settlement price fields in the market. For most markets, this is the same as DealPriceDenominator'
      - id: mic_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Identifier Code for the market'
      - id: unit_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for UnitQuantity. This field will be ‘0’ for most of the markets'
      - id: hedge_only
        type: u1
        enum: hedge_only
        doc: 'Indicate if the contract is for hedge only. ‘Y’ or ‘N’'
      - id: exchange_silo
        type: u1
        enum: exchange_silo
        doc: 'Exchange silo code for the market'
      - id: off_exchange_increment_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for OffExchangeIncrementQty'
      - id: off_exchange_increment_qty
        type: s4
        doc: 'Off exchange increment qty. OffExchangeIncrementQtyDenominator should be applied to this field'
      - id: off_exchange_increment_price
        type: s4
        doc: 'Off exchange increment price'
      - id: off_exchange_increment_option_price
        type: s4
        doc: 'Off exchange options increment price. NumDecimalsOptionsPrice should be applied to this field'
      - id: product_id
        type: s4
        doc: 'ID of the product that the contract/market is under'
      - id: hub_id
        type: s4
        doc: 'ID of the hub for the contract/market'
      - id: strip_id
        type: s4
        doc: 'StripID'
      - id: underlying_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ISIN of the security this market is associated with. This is currently only populated for Liffe Equity markets'
      - id: test_market_indicator
        type: u1
        enum: test_market_indicator
        doc: 'Indicates Test Market. ‘Y’ or ‘N’'
      - id: leg_deal_suppressed
        type: u1
        enum: leg_deal_suppressed
        doc: 'Indicates whether leg deals are suppressed. ‘Y’ or ‘N’'
  leg_definition:
    seq:
      - id: leg_body_length
        type: s1
        doc: 'Message length, including this field, for a leg'
      - id: leg_market_id
        type: s4
        doc: 'Market Id of the futures leg'
      - id: leg_ratio
        type: s2
        doc: 'Number of futures contracts per increment quantity'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Number of futures contracts per increment quantity'
      - id: leg_strategy_code
        type: s2
        doc: 'Leg Strategy Code'
      - id: leg_ratio_qty_numerator
        type: s4
        doc: 'Leg Ratio Qty Numerator'
      - id: leg_ratio_qty_denominator
        type: s4
        doc: 'Leg Ratio Qty Denominator'
      - id: leg_ratio_price_numerator
        type: s4
        doc: 'Leg Ratio Price Numerator'
      - id: leg_ratio_price_denominator
        type: s4
        doc: 'Leg Ratio Price Denominator'
  new_expiry_message:
    seq:
      - id: market_id
        type: s4
      - id: market_type_id
        type: s2
        enum: market_type_id
        doc: 'List of market types and IDs'
      - id: order_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the order price fields in this market'
      - id: increment_price
        type: s4
        doc: 'Minimum increment premium price for this market. OrderPriceDenominator should be applied to this field'
      - id: increment_qty
        type: s4
        doc: 'Minimum increment quantity for this market'
      - id: lot_size
        type: s4
        doc: 'The lot size is minimum size of contracts in lots. It is multiplier to determine the total lots'
      - id: market_desc
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description of the market'
      - id: maturity_year
        type: s2
        doc: '4 digit year'
      - id: maturity_month
        type: s2
        doc: 'Month range 1-12'
      - id: maturity_day
        type: s2
      - id: deal_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the deal price fields in the market. For most markets, this is the same as OrderPriceDenominator. However, it could be different for some crack or spread markets'
      - id: min_qty
        type: s4
        doc: 'Minimum quantity for this market'
      - id: unit_quantity
        type: s4
        doc: 'The quantity in unit of measurement per lot. For example, it is 1000 barrels per lot for Brent'
      - id: currency
        type: str
        size: 20
        encoding: ASCII
        doc: 'The currency that the market is traded on'
      - id: cleared_alias
        type: str
        size: 15
        encoding: ASCII
        doc: 'Clearing limit admin related'
      - id: min_price
        type: s8
        doc: 'Minimum Price. OrderPriceDenominator should be applied to this field'
      - id: max_price
        type: s8
        doc: 'Maximum Price. OrderPriceDenominator should be applied to this field'
      - id: product_id
        type: s4
        doc: 'ID of the product that the contract/market is under'
      - id: product_name
        type: str
        size: 62
        encoding: ASCII
        doc: 'Name of the product that the contract/market is under'
      - id: hub_id
        type: s4
        doc: 'ID of the hub for the contract/market'
      - id: hub_alias
        type: str
        size: 80
        encoding: ASCII
        doc: 'Alias of the hub for the contract/market'
      - id: strip_id
        type: s4
        doc: 'StripID'
      - id: strip_name
        type: str
        size: 39
        encoding: ASCII
        doc: 'Name of the strip for the contract/market'
      - id: settle_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the settlement price fields in the market. For most markets, this is the same as DealPriceDenominator'
      - id: mic_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Identifier Code for the market'
      - id: unit_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for UnitQuantity. This field will be ‘0’ for most of the markets'
      - id: off_exchange_increment_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for OffExchangeIncrementQty'
      - id: off_exchange_increment_qty
        type: s4
        doc: 'Off exchange increment qty. OffExchangeIncrementQtyDenominator should be applied to this field'
      - id: off_exchange_increment_price
        type: s4
        doc: 'Off exchange increment price'
      - id: off_exchange_increment_option_price
        type: s4
        doc: 'Off exchange options increment price. NumDecimalsOptionsPrice should be applied to this field'
      - id: contract_symbol
        type: str
        size: 35
        encoding: ASCII
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ISIN of the security this market is associated with. This is currently only populated for Liffe Equity markets'
      - id: num_decimals_options_price
        type: str
        size: 1
        encoding: ASCII
        doc: 'Only used for OffExchangeIncrementOptionPrice'
      - id: hedge_market_id
        type: s4
        doc: 'Future’s market id of the hedge'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement Type: ‘0’ - financial, ‘1’ - physical'
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'Indicates if GTC is allowed in the market. ‘Y’ or ‘N’'
      - id: cross_order_supported
        type: u1
        enum: cross_order_supported
        doc: 'Indicates if Cross Order is supported in the market. ‘Y’ or ‘N’'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
      - id: mifid_regulated_market
        type: u1
        enum: mifid_regulated_market
        doc: 'Indicates MIFID-II market. ‘Y’ or ‘N’'
  special_field_message:
    seq:
      - id: num_special_field
        type: s1
        doc: 'Number of Fields present on this message'
      - id: special_field
        type: special_field
        repeat: expr
        repeat-expr: num_special_field
        doc: 'Special Field'
  special_field:
    seq:
      - id: special_field_id
        type: s1
        enum: special_field_id
        doc: 'Special field type'
      - id: len_variable_field
        type: s2
        doc: 'Length of this field'
      - id: variable_field
        size: len_variable_field
  market_snapshot_order_message:
    seq:
      - id: market_id
        type: s4
      - id: order_id
        type: s8
        doc: 'Unique per market'
      - id: order_sequence_id
        type: s2
        doc: 'Sequence ID of the order. When an order is modified, this will be incremented while OrderID remains the same. It is for legacy reason and can be ignored'
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: is_implied
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate if this is an implied order or not'
      - id: is_rfq
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate whether it is just an RFQ or not. Client should filter the order if it doesn’t care about RFQ'
      - id: order_entry_date_time
        type: millisecond_timestamp
        doc: 'Order entry date time. Milliseconds since Unix epoch'
      - id: sequence_within_millis
        type: s4
        doc: 'Can be used in conjunction with TransactDateTime field for sequence of deals within same milliseconds time'
  add_or_modify_order_message:
    seq:
      - id: market_id
        type: s4
      - id: order_id
        type: s8
        doc: 'Unique per market'
      - id: order_sequence_id
        type: s2
        doc: 'Sequence ID of the order. When an order is modified, this will be incremented while OrderID remains the same. It is for legacy reason and can be ignored'
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: is_implied
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate if this is an implied order or not'
      - id: is_rfq
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicate whether it is just an RFQ or not. Client should filter the order if it doesn’t care about RFQ'
      - id: order_entry_date_time
        type: millisecond_timestamp
        doc: 'Order entry date time. Milliseconds since Unix epoch'
      - id: extra_flags
        type: s1
        doc: 'Flags'
      - id: sequence_within_millis
        type: s4
        doc: 'Can be used in conjunction with TransactDateTime field for sequence of deals within same milliseconds time'
      - id: modification_timestamp
        type: nanosecond_timestamp
        doc: 'This field can be used to get the order modification time. Nanoseconds since Unix epoch'
  delete_order_message:
    seq:
      - id: market_id
        type: s4
      - id: order_id
        type: s8
        doc: 'Unique per market'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: sequence_within_millis
        type: s4
        doc: 'Can be used in conjunction with TransactDateTime field for sequence of deals within same milliseconds time'
  message_bundle_marker:
    seq:
      - id: start_or_end
        type: u1
        enum: start_or_end
        doc: 'Marker'
  fixing_transition_message:
    seq:
      - id: market_id
        type: s4
      - id: status
        type: u1
        enum: status
        doc: 'For Endex Spot markets'
      - id: auction_end_time
        type: millisecond_timestamp
        doc: 'Date time the Auction will end. Milliseconds since Unix epoch'
      - id: threshold_imbalance_qty
        type: s4
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
  fixing_lockdown_message:
    seq:
      - id: market_id
        type: s4
      - id: auction_date
        type: str
        size: 10
        encoding: ASCII
        doc: 'Date format'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: description
        type: str
        size: 20
        encoding: ASCII
        doc: 'The auction runs twice daily at 10:30am and 3:00pm London time. The values disseminated via this field are: ‘GOLD_1030’, ‘GOLD_1500’'
      - id: round
        type: s2
      - id: agg_bid_qty
        type: s4
        doc: 'Aggregate bid quantity'
      - id: agg_offer_qty
        type: s4
        doc: 'Aggregate offer quantity'
      - id: usd_price
        type: s8
        doc: 'Auctioneers price for the round in USD. Use 2 decimal places for USD Price'
      - id: is_balanced
        type: u1
        enum: is_balanced
        doc: '‘Y’/’N’'
      - id: is_final
        type: u1
        enum: is_final
        doc: '‘Y’/’N’'
      - id: gbp_price
        type: s8
        doc: 'Obsolete. The price will be published via the Fixing Indicative Price Message'
      - id: eur_price
        type: s8
        doc: 'Obsolete. The price will be published via the Fixing Indicative Price Message'
  fixing_indicative_price_message_message:
    seq:
      - id: market_id
        type: s4
      - id: iba_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency Code'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: price_in_gram
        type: s8
        doc: 'Auctioneers price in gram for the round in specified currency'
      - id: num_decimals_price
        type: s1
        doc: 'Number of decimals to use for Prices'
      - id: num_decimals_price_in_gram
        type: s1
        doc: 'Number of decimals to use for PriceInGram'
  market_snapshot_price_level_message:
    seq:
      - id: market_id
        type: s4
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price_level_position
        type: s1
        doc: 'Position of the price level'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: order_count
        type: s2
        doc: 'Number of all orders at the price level'
      - id: implied_quantity
        type: s4
        doc: 'Quantity that were implied'
      - id: implied_order_count
        type: s2
        doc: 'Number of implied orders at the price level'
  add_price_level_message:
    seq:
      - id: market_id
        type: s4
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price_level_position
        type: s1
        doc: 'Position of the price level'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: order_count
        type: s2
        doc: 'Number of all orders at the price level'
      - id: implied_quantity
        type: s4
        doc: 'Quantity that were implied'
      - id: implied_order_count
        type: s2
        doc: 'Number of implied orders at the price level'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of last update used to derive the price level message. Nanoseconds since Unix epoch'
  change_price_level_message:
    seq:
      - id: market_id
        type: s4
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price_level_position
        type: s1
        doc: 'Position of the price level'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: order_count
        type: s2
        doc: 'Number of all orders at the price level'
      - id: implied_quantity
        type: s4
        doc: 'Quantity that were implied'
      - id: implied_order_count
        type: s2
        doc: 'Number of implied orders at the price level'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of last update used to derive the price level message. Nanoseconds since Unix epoch'
  delete_price_level_message:
    seq:
      - id: market_id
        type: s4
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
      - id: price_level_position
        type: s1
        doc: 'Position of the price level'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of last update used to derive the price level message. Nanoseconds since Unix epoch'
  new_options_strategy_definition_message:
    seq:
      - id: market_id
        type: s4
      - id: underlying_market_id
        type: s4
        doc: 'Unique identifier of the underlying market'
      - id: contract_symbol
        type: str
        size: 35
        encoding: ASCII
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Appendix A on the trading status codes'
      - id: order_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the order price fields in this market'
      - id: increment_price
        type: s4
        doc: 'Minimum increment premium price for this market. OrderPriceDenominator should be applied to this field'
      - id: increment_qty
        type: s4
        doc: 'Minimum increment quantity for this market'
      - id: min_qty
        type: s4
        doc: 'Minimum quantity for this market'
      - id: num_strategy_leg_definition
        type: s1
        doc: 'Number of strategy leg definitions. The leg info are in repeating group followed'
      - id: strategy_leg_definition
        type: strategy_leg_definition
        repeat: expr
        repeat-expr: num_strategy_leg_definition
        doc: 'Strategy Leg Definition'
      - id: num_hedge_definition
        type: s1
        doc: 'Number of hedge definitions'
      - id: hedge_definition
        type: hedge_definition
        repeat: expr
        repeat-expr: num_hedge_definition
        doc: 'Hedge Definition'
      - id: security_sub_type
        type: s2
        enum: security_sub_type
        doc: 'Contains the Strategy Code for defined market where applicable. See Appendix E for list of codes'
      - id: is_block_only
        type: u1
        enum: is_block_only
        doc: 'Indicates if Market is only tradable via ICE Block Trade. This also means the screen trading is not allowed for the market. ‘Y’ or ‘N’'
      - id: strategy_symbol
        type: str
        size: 18
        encoding: ASCII
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'Indicates if GTC is allowed in the market. ‘Y’ or ‘N’'
      - id: mifid_regulated_market
        type: u1
        enum: mifid_regulated_market
        doc: 'Indicates MIFID-II market. ‘Y’ or ‘N’'
      - id: deal_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the deal price fields in the market. For most markets, this is the same as OrderPriceDenominator. However, it could be different for some crack or spread markets'
      - id: settle_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the settlement price fields in the market. For most markets, this is the same as DealPriceDenominator'
      - id: unit_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for UnitQuantity. This field will be ‘0’ for most of the markets'
      - id: test_market_indicator
        type: u1
        enum: test_market_indicator
        doc: 'Indicates Test Market. ‘Y’ or ‘N’'
      - id: contract_symbol_extra
        type: str
        size: 35
        encoding: ASCII
        doc: 'Extra contract symbol. Some contract symbols might contain more than 35 characters. Clients should append this field to ContractSymbol (Offset 11) to get the complete contract symbol'
      - id: leg_deal_suppressed
        type: u1
        enum: leg_deal_suppressed
        doc: 'Indicates whether leg deals are suppressed. ‘Y’ or ‘N’'
  strategy_leg_definition:
    seq:
      - id: leg_body_length
        type: s1
        doc: 'Message length, including this field, for a leg'
      - id: leg_market_id
        type: s4
        doc: 'Market Id of the futures leg'
      - id: leg_underlying_market_id
        type: s4
        doc: 'Futures market id of the underlying futures market'
      - id: leg_ratio
        type: s2
        doc: 'Number of futures contracts per increment quantity'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Number of futures contracts per increment quantity'
      - id: leg_strategy_code
        type: s2
        doc: 'Leg Strategy Code'
      - id: leg_ratio_qty_numerator
        type: s4
        doc: 'Leg Ratio Qty Numerator'
      - id: leg_ratio_qty_denominator
        type: s4
        doc: 'Leg Ratio Qty Denominator'
      - id: leg_ratio_price_numerator
        type: s4
        doc: 'Leg Ratio Price Numerator'
      - id: leg_ratio_price_denominator
        type: s4
        doc: 'Leg Ratio Price Denominator'
  hedge_definition:
    seq:
      - id: hedge_body_length
        type: s1
        doc: 'Message length, including this field, for a hedge'
      - id: hedge_market_id
        type: s4
        doc: 'Future’s market id of the hedge'
      - id: hedge_security_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Futures'
      - id: hedge_side
        type: u1
        enum: hedge_side
        doc: 'Number of futures contracts per increment quantity'
      - id: hedge_price
        type: s8
        doc: 'HedgePrice'
      - id: hedge_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Hedge Price Denominator'
      - id: hedge_delta
        type: s2
        doc: 'Hedge Delta'
      - id: hedge_strategy_code
        type: s2
        doc: 'Hedge Strategy Code'
  new_options_market_definition_message:
    seq:
      - id: market_id
        type: s4
      - id: underlying_market_id
        type: s4
        doc: 'Unique identifier of the underlying market'
      - id: futures_contract_symbol
        type: str
        size: 70
        encoding: ASCII
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Appendix A on the trading status codes'
      - id: order_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the order price fields in this market'
      - id: increment_qty
        type: s4
        doc: 'Minimum increment quantity for this market'
      - id: lot_size
        type: s4
        doc: 'The lot size is minimum size of contracts in lots. It is multiplier to determine the total lots'
      - id: market_desc
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description of the market'
      - id: option_type
        type: u1
        enum: option_type
        doc: '“C” – Call, “P” – Put'
      - id: strike_price
        type: s8
        doc: 'Strike Price of the option. Used in conjunction with the NumDecimalsStrikePrice. This is often different from the premium price decimals'
      - id: deal_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the deal price fields in the market. For most markets, this is the same as OrderPriceDenominator. However, it could be different for some crack or spread markets'
      - id: min_qty
        type: s4
        doc: 'Minimum quantity for this market'
      - id: currency
        type: str
        size: 20
        encoding: ASCII
        doc: 'The currency that the market is traded on'
      - id: num_decimals_strike_price
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the strike price field'
      - id: min_options_price
        type: s8
        doc: 'Minimum premium price for the option'
      - id: max_options_price
        type: s8
        doc: 'Maximum premium price for the option'
      - id: increment_premium_price
        type: s4
        doc: 'Price increment for the option market'
      - id: options_expiration_year
        type: s2
        doc: '4 digit year'
      - id: options_expiration_month
        type: s2
        doc: 'Month range 1-12'
      - id: options_expiration_day
        type: s2
        doc: 'Day of the month'
      - id: options_style
        type: u1
        enum: options_style
        doc: 'OptionsStyle: ‘A’ – American, ‘E’ – European, ‘0’ – None, ‘3’ – Asian, ‘4’ – One Time'
      - id: options_expiration_type
        type: u1
        enum: options_expiration_type
        doc: 'Options expiration type: ‘M’ – Monthly ‘D’ – Daily'
      - id: hedge_market_id
        type: s4
        doc: 'Future’s market id of the hedge'
      - id: settle_price_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for the settlement price fields in the market. For most markets, this is the same as DealPriceDenominator'
      - id: unit_qty_denominator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denominator for UnitQuantity. This field will be ‘0’ for most of the markets'
      - id: tick_value
        type: s8
        doc: 'OrderPriceDenominator should be applied to get the real value'
      - id: flex_allowed
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates if flexible strikes can be created for the option market. ‘Y’ or ‘N’'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement Type: ‘0’ - financial, ‘1’ - physical'
      - id: is_block_only
        type: u1
        enum: is_block_only
        doc: 'Indicates if Market is only tradable via ICE Block Trade. This also means the screen trading is not allowed for the market. ‘Y’ or ‘N’'
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'Indicates if GTC is allowed in the market. ‘Y’ or ‘N’'
      - id: cross_order_supported
        type: u1
        enum: cross_order_supported
        doc: 'Indicates if Cross Order is supported in the market. ‘Y’ or ‘N’'
      - id: guaranteed_cross_supported
        type: u1
        enum: guaranteed_cross_supported
        doc: 'Indicates if Guarantee Cross is supported in the market. ‘Y’ or ‘N’'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
      - id: mifid_regulated_market
        type: u1
        enum: mifid_regulated_market
        doc: 'Indicates MIFID-II market. ‘Y’ or ‘N’'
  rfq_message:
    seq:
      - id: market_id
        type: s4
      - id: message_timestamp
        type: millisecond_timestamp
        doc: 'Date time of the RFQ. Milliseconds since Unix epoch'
      - id: rfq_system_id
        type: s8
        doc: 'System ID of the RFQ'
      - id: market_type_id
        type: s2
        enum: market_type_id
        doc: 'List of market types and IDs'
      - id: underlying_market_id
        type: s4
        doc: 'Unique identifier of the underlying market'
      - id: quantity
        type: s4
      - id: side
        type: u1
        enum: side
        doc: '1 = Bid, 2 = Offer'
  option_open_interest_message:
    seq:
      - id: market_id
        type: s4
      - id: open_interest
        type: s4
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: open_interest_date
        type: iso_date
        doc: 'The date Open Interest is effective for'
  option_settlement_price_message:
    seq:
      - id: market_id
        type: s4
      - id: settlement_price_with_deal_price_precision
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get this price'
      - id: message_date_time
        type: millisecond_timestamp
        doc: 'Date time the trade was investigated. Milliseconds since Unix epoch'
      - id: is_official
        type: u1
        enum: is_official
        doc: 'Flag to indicate this is official settlement price or not'
      - id: valuation_date_time
        type: millisecond_timestamp
        doc: 'Date time the settlement price is for. Milliseconds since Unix epoch'
      - id: volatility
        type: s8
        doc: 'Apply 2 as the denominator to get the real value. For example, volatility of 3.00 will be sent as 300'
      - id: settlement_price
        type: s8
        doc: 'SettlePriceDenominator for the market should be applied to get the real settlement price'
      - id: delta
        type: s8
        doc: 'Apply 2 as the denominator to get the real value. For example, delta of 3.00 will be sent as 300'
  old_style_options_trade_and_market_stats_message:
    seq:
      - id: underlying_market_id
        type: s4
        doc: 'Unique identifier of the underlying market'
      - id: trade_id
        type: s8
        doc: 'Unique identifier of the trade message, unique per market'
      - id: price
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: quantity
        type: s4
      - id: off_market_trade_indicator
        type: u1
        enum: off_market_trade_indicator
        doc: 'Legacy field that supports all single character trade types on ICE. The new 3-character “OffMarketTradeType” field replaces this field. In the future (no earlier than 2015), ICE anticipates the introduction of 3 character trade types that will only be available in the new field. Trade types that are longer than a single character will be represented with “#” in this field'
      - id: transact_date_time
        type: millisecond_timestamp
        doc: 'Deal date time. Milliseconds since Unix epoch'
      - id: option_type
        type: u1
        enum: option_type
        doc: '“C” – Call, “P” – Put'
      - id: strike_price
        type: s8
        doc: 'Strike Price of the option. Used in conjunction with the NumDecimalsStrikePrice. This is often different from the premium price decimals'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event code: ‘0’ – Normal trade, ‘1’ – Cancelled trade, ‘2’ – Adjusted trade'
      - id: total_volume
        type: s4
        doc: 'N/A if set to -1'
      - id: block_volume
        type: s4
      - id: efs_volume
        type: s4
      - id: efp_volume
        type: s4
      - id: high
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: low
        type: s8
        doc: 'DealPriceDenominator for the market should be applied to get the real price'
      - id: vwap
        type: s8
        doc: 'Weighted Average Price. DealPriceDenominator for the market should be applied to get the real price'
  millisecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  iso_date:
    seq:
      - id: text
        type: str
        size: 10
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(5, 7).to_i
      day:
        value: text.substring(8, 10).to_i
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

enums:
  message_type:
    0x43:
      id: 'market_snapshot_message'
      doc: 'The market snapshot message is the same for full order depth and price level snapshot channel.'
    0x47:
      id: 'trade_message'
      doc: 'A trade with IsSystemPricedLeg equal to ‘Y’ should not be used for the last price, High, Low and Open. Also please refer to Appendix B on how to handle market stats for given OffTradeMarketType. This message will not be sent for trades in Endex Spot markets.'
    0x59:
      id: 'spot_market_trade_message'
      doc: 'This message will be sent only upon trade in spot markets and it will be rendered on spot market channels.'
    0x48:
      id: 'investigated_trade_message'
      doc: 'This message is sent when a trade is put under investigation or the investigation is completed. Client can use the market ID and order ID to find and flag the original trade if needed.'
    0x49:
      id: 'cancelled_trade_message'
      doc: 'This message is sent when a trade is cancelled.'
    0x4a:
      id: 'market_statistics_message'
      doc: 'This is usually sent after a trade or cancelled trade message.'
    0x4b:
      id: 'market_state_change_message'
      doc: 'Market State Change Message'
    0x4c:
      id: 'system_text_message'
      doc: 'System Text Message'
    0x4d:
      id: 'open_interest_message'
      doc: 'Open Interest Message'
    0x4e:
      id: 'open_price_message'
      doc: 'Open Price Message'
    0x63:
      id: 'close_price_message'
      doc: 'Close Price Message'
    0x4f:
      id: 'settlement_price_message'
      doc: 'Settlement prices could be official or unofficial. For a given market, the exchange usually sends out unofficial price before the official one.'
    0x7a:
      id: 'index_prices_message'
      doc: 'The exchange sends out Marker/Index Prices when there is an update.'
    0x75:
      id: 'end_of_day_market_summary_message'
      doc: 'The message is streamed to client when market is closed and settlement price is available for the current trading day.'
    0x66:
      id: 'market_event_message'
      doc: 'End of Day Market Summary Message'
    0x67:
      id: 'pre_open_price_indicator_message'
      doc: 'This message contains the estimate of what the opening price could be, based on the orders in the market or previous settlement price.'
    0x69:
      id: 'strip_info_message'
      doc: 'This message will be sent out if there is strip date change during the trading session. If client does not care about strip date changes, client should ignore these messages.'
    0x56:
      id: 'interval_price_limit_notification_message'
      doc: 'Interval Price Limit (IPL) might be enabled for certain markets. IPL check is to prevent sudden movements (in both directions) in the market during a short period of time.'
    0x39:
      id: 'new_futures_strategy_definition_message'
      doc: 'New Futures Strategy Definition messages will be sent out when new UDS markets for futures are created.'
    0x52:
      id: 'new_expiry_message'
      doc: 'New Expiry message will be sent out when a new equity market is created during the day.'
    0x62:
      id: 'special_field_message'
      doc: 'The Special Field Message is used to send extra information on existing messages.'
    0x44:
      id: 'market_snapshot_order_message'
      doc: 'This message is for orders in snapshot only. It is different from the order message for incremental updates.'
    0x45:
      id: 'add_or_modify_order_message'
      doc: 'Client should add the order to book if it is not there already. Otherwise, just overwrite the existing order.'
    0x46:
      id: 'delete_order_message'
      doc: 'Upon receipt of this message, client should remove the order from its local book.'
    0x54:
      id: 'message_bundle_marker'
      doc: 'This message indicates where a bundle of messages starts or ends.'
    0x33:
      id: 'fixing_transition_message'
      doc: 'This message supports ICE Benchmark Administration’s (IBA) electronic Gold Auction and it is disseminated when there is a transition of the fixing market.'
    0x34:
      id: 'fixing_lockdown_message'
      doc: 'This message supports ICE Benchmark Administration’s (IBA) electronic Gold Auction and it is disseminated when there is a transition of the fixing market.'
    0x30:
      id: 'fixing_indicative_price_message_message'
      doc: 'This message supports ICE Benchmark Administration’s (IBA) electronic Gold and Silver Auction and is disseminated at the end of the final auction when the final price is published'
    0x6d:
      id: 'market_snapshot_price_level_message'
      doc: 'This message is for price level in snapshot only.'
    0x74:
      id: 'add_price_level_message'
      doc: 'Upon receipt of this message, client should add/insert a price level at the specified position in the book for the given market, and push down the price levels that were previously at or below that position.'
    0x73:
      id: 'change_price_level_message'
      doc: 'Upon receipt of this message, client should update the price level at the specified position in its book for the given market.'
    0x72:
      id: 'delete_price_level_message'
      doc: 'Upon receipt of this message, client should remove the price level at the specified position in its book for the given market.'
    0x55:
      id: 'new_options_strategy_definition_message'
      doc: 'New Options Strategy Definition messages will be sent out when new UDS markets for options are created.'
    0x6c:
      id: 'new_options_market_definition_message'
      doc: 'New Options Market Definition messages will be sent out when new options markets are created.'
    0x6b:
      id: 'rfq_message'
      doc: 'Request for Quote Message.'
    0x76:
      id: 'option_open_interest_message'
      doc: 'Option Open Interest Message'
    0x77:
      id: 'option_settlement_price_message'
      doc: 'Option settlement prices could be official or unofficial. For a given market, the exchange usually sends out unofficial price before the official one.'
    0x57:
      id: 'old_style_options_trade_and_market_stats_message'
      doc: 'Option settlement prices could be official or unofficial. For a given market, the exchange usually sends out unofficial price before the official one.'
  trading_status:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x45:
      id: 'expired'
      doc: 'Expired'
    0x31:
      id: 'pre_open'
      doc: 'Pre Open'
    0x32:
      id: 'pre_close'
      doc: 'Pre Close'
  is_settle_price_official:
    0x59:
      id: 'yes_field'
      doc: 'Settle Price Is Official'
    0x4e:
      id: 'no_field'
      doc: 'Settle Price Is Not Official'
  has_previous_day_settlement_price:
    0x4e:
      id: 'no_field'
      doc: 'No Previous Day Settlement Price'
    0x59:
      id: 'yes_field'
      doc: 'Has Previous Day Settlement Price'
  is_system_priced_leg:
    0x59:
      id: 'yes_field'
      doc: 'Leg Is'
    0x4e:
      id: 'no_field'
      doc: 'Settle Price Is Not Official'
  off_market_trade_indicator:
    0x20:
      id: 'regular'
      doc: 'Regular'
    0x4b:
      id: 'block'
      doc: 'Block'
    0x53:
      id: 'efs'
      doc: 'Efs'
    0x45:
      id: 'efp'
      doc: 'Efp'
    0x4f:
      id: 'efp_efs'
      doc: 'Efp Efs'
    0x51:
      id: 'eoo'
      doc: 'Eoo'
    0x49:
      id: 'efm'
      doc: 'Efm'
    0x35:
      id: 'guaranteed_cross'
      doc: 'Guaranteed Cross'
    0x34:
      id: 'basis'
      doc: 'Basis'
  system_priced_leg_type:
    0x43:
      id: 'system_priced_crack_spread_leg'
      doc: 'System Priced Crack Spread Leg'
    0x53:
      id: 'system_priced_leg'
      doc: 'System Priced Leg'
  aggressor_side:
    0x20:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  investigation_status:
    0x31:
      id: 'under_investigation'
      doc: 'Under Investigation'
    0x32:
      id: 'investigation_completed'
      doc: 'Investigation Completed'
  is_official:
    0x59:
      id: 'yes_field'
      doc: 'Official Settlement Price'
    0x4e:
      id: 'no_field'
      doc: 'Not Official Settlement Price'
  status:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x50:
      id: 'preopen'
      doc: 'Preopen'
    0x4c:
      id: 'lockdown'
      doc: 'Lockdown'
  ipl_hold_type:
    0x53:
      id: 'ipl_hold_start'
      doc: 'Interval Price Limit Hold Start'
    0x45:
      id: 'ipl_hold_end'
      doc: 'Interval Price Limit Hold End'
  is_up:
    0x59:
      id: 'ipl_upper_bound_violation'
      doc: 'Ipl Upper Bound Violation Bidding Too High'
    0x4e:
      id: 'ipl_lower_bound_violation'
      doc: 'Ipl Lower Bound Violation Asking Too Low'
    0x46:
      id: 'final_field'
      doc: 'Final'
    0x20:
      id: 'non_endex_spot_market'
      doc: 'Non Endex Spot Market'
  leg_side:
    0x20:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'bid'
      doc: 'Bid'
    0x32:
      id: 'offer'
      doc: 'Offer'
  security_sub_type:
    0:
      id: 'none'
      doc: 'Na'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
    3:
      id: 'futures_butterfly'
      doc: 'Ffly'
    4:
      id: 'call_butterfly'
      doc: 'Callfly'
    5:
      id: 'put_butterfly'
      doc: 'Putfly'
    6:
      id: 'call_spread'
      doc: 'Callspr'
    7:
      id: 'put_spread'
      doc: 'Putspr'
    9:
      id: 'diagonal_call_spread'
      doc: 'Calldiagsp'
    10:
      id: 'diagonal_put_spread'
      doc: 'Putdiagsp'
    11:
      id: 'gut_strangle'
      doc: 'Gut'
    12:
      id: 'one_by_two_call_spread_to_the_two'
      doc: 'Ratiocspr'
    13:
      id: 'one_by_two_put_spread_to_the_two'
      doc: 'Ratiopspr'
    14:
      id: 'iron_butterfly'
      doc: 'Ifly'
    16:
      id: 'strangle'
      doc: 'Strangle'
    17:
      id: 'call_ladder_tree'
      doc: 'Callladr'
    18:
      id: 'put_ladder_tree'
      doc: 'Putladr'
    19:
      id: 'straddle_spread'
      doc: 'Calstrd'
    21:
      id: 'reversal_conversion'
      doc: 'Revcon'
    22:
      id: 'straddle'
      doc: 'Straddle'
    23:
      id: 'futures_condor'
      doc: 'Fcondr'
    24:
      id: 'call_condor'
      doc: 'Callcondr'
    25:
      id: 'put_condor'
      doc: 'Putcondr'
    26:
      id: 'box_field'
      doc: 'Box'
    33:
      id: 'synthetic_underlying'
      doc: 'Syn'
    34:
      id: 'call_spread_vs_put_3_way'
      doc: 'Callsprp'
    35:
      id: 'put_spread_vs_call_3_way'
      doc: 'Putsprc'
    36:
      id: 'straddle_vs_call_3_way'
      doc: 'Call 3 Way'
    37:
      id: 'straddle_vs_put_3_way'
      doc: 'Put 3 Way'
    38:
      id: 'call_calendar_spread'
      doc: 'Callcalspr'
    39:
      id: 'put_calendar_spread'
      doc: 'Putcalspr'
    40:
      id: 'iron_condor'
      doc: 'Icondr'
    41:
      id: 'jelly_roll'
      doc: 'Jroll'
    42:
      id: 'hedged_one_by_two_call_spread_to_the_two'
      doc: 'Ratiocsprx'
    43:
      id: 'hedged_one_by_two_put_spread_to_the_two'
      doc: 'Ratiopsprx'
    44:
      id: 'call_spread_versus_sell_put_hedge'
      doc: 'Sprvspx'
    45:
      id: 'put_spread_versus_sell_call_hedge'
      doc: 'Sprvscx'
    46:
      id: 'hedged_call_calendar'
      doc: 'Callcalx'
    47:
      id: 'hedged_put_calendar'
      doc: 'Putcalx'
    48:
      id: 'hedged_call_ladder_tree'
      doc: 'Callladrx'
    49:
      id: 'hedged_put_ladder_tree'
      doc: 'Putladrx'
    50:
      id: 'hedged_call_spread'
      doc: 'Callsprx'
    51:
      id: 'hedged_put_spread'
      doc: 'Putsprx'
    53:
      id: 'hedged_straddle'
      doc: 'Strdx'
    54:
      id: 'hedged_strangle'
      doc: 'Strgx'
    55:
      id: 'hedged_call'
      doc: 'Callx'
    56:
      id: 'hedged_put'
      doc: 'Putx'
    58:
      id: 'custom'
      doc: 'Cust'
    59:
      id: 'hedged_straddle_spread'
      doc: 'Calstrdx'
    60:
      id: 'hedged_call_condor'
      doc: 'Ccondrx'
    61:
      id: 'hedged_put_condor'
      doc: 'Pcondrx'
    63:
      id: 'hedged_diagonal_call_spread'
      doc: 'Cdiagx'
    64:
      id: 'hedged_diagonal_put_spread'
      doc: 'Pdiagx'
    65:
      id: 'hedged_call_butterlfy'
      doc: 'Cflyx'
    66:
      id: 'hedged_put_butterlfy'
      doc: 'Pflyx'
    67:
      id: 'hedged_guts_strangle'
      doc: 'Gutx'
    68:
      id: 'hedged_iron_condor'
      doc: 'Icondrx'
    69:
      id: 'hedged_iron_butterfly'
      doc: 'Iflyx'
    70:
      id: 'fence_to_the_call'
      doc: 'Fencecall'
    71:
      id: 'fence_to_the_put'
      doc: 'Fenceput'
    72:
      id: 'hedged_fence_to_the_call'
      doc: 'Fencecallx'
    73:
      id: 'hedged_fence_to_the_put'
      doc: 'Fenceputx'
    74:
      id: 'one_by_two_call_spread_to_the_one'
      doc: 'Ratio C Spr 1'
    75:
      id: 'one_by_two_put_spread_to_the_one'
      doc: 'Ratio P Spr 1'
    76:
      id: 'hedged_one_by_two_call_spread_to_the_one'
      doc: 'Ratio C Spr 1 X'
    77:
      id: 'hedged_one_by_two_put_spread_to_the_one'
      doc: 'Ratio P Spr 1 X'
    88:
      id: 'discount_spreads'
      doc: 'Discspr'
    89:
      id: 'location_spreads'
      doc: 'Locspr'
    90:
      id: 'platts_diff_spread'
      doc: 'Platdifspr'
    91:
      id: 'platts_spread'
      doc: 'Plattspr'
    92:
      id: 'otc_gas_oil_crack'
      doc: 'Oilcrack'
    93:
      id: 'balmo_over_month'
      doc: 'Balmospr'
    94:
      id: 'ratio_spread'
      doc: 'Ratiospr'
    95:
      id: 'volumetric_spread'
      doc: 'Volspr'
    96:
      id: 'heat_rate'
      doc: 'Heatrate'
    97:
      id: 'crack_spread'
      doc: 'Crack'
    98:
      id: 'combo_spread'
      doc: 'Combospr'
    99:
      id: 'spread_s'
      doc: 'Spr'
    100:
      id: 'packno_color'
      doc: 'Pack'
    101:
      id: 'pack_white'
      doc: 'Whtpack'
    102:
      id: 'pack_red'
      doc: 'Redpack'
    103:
      id: 'pack_green'
      doc: 'Grnpack'
    104:
      id: 'pack_blue'
      doc: 'Blupack'
    105:
      id: 'pack_gold'
      doc: 'Gldpack'
    106:
      id: 'pack_purple'
      doc: 'Purpack'
    107:
      id: 'pack_orange'
      doc: 'Ornpack'
    108:
      id: 'pack_pink'
      doc: 'Pnkpack'
    109:
      id: 'pack_silver'
      doc: 'Silpack'
    110:
      id: 'pack_copper'
      doc: 'Coppack'
    200:
      id: 'bundle_no_color'
      doc: 'Bndl'
    201:
      id: 'bundle_2_yr'
      doc: 'Bndly 2'
    202:
      id: 'bundle_3_yr'
      doc: 'Bndly 3'
    203:
      id: 'bundle_4_yr'
      doc: 'Bndly 4'
    204:
      id: 'bundle_5_yr'
      doc: 'Bndly 5'
    205:
      id: 'bundle_6_yr'
      doc: 'Bndly 6'
    206:
      id: 'bundle_7_yr'
      doc: 'Bndly 7'
    207:
      id: 'bundle_8_yr'
      doc: 'Bndly 8'
    208:
      id: 'bundle_9_yr'
      doc: 'Bndly 9'
    209:
      id: 'bundle_10_yr'
      doc: 'Bndly 10'
    400:
      id: 'balmo'
      doc: 'Balmo'
    410:
      id: 'next_day'
      doc: 'Nextday'
    411:
      id: 'cfd'
      doc: 'Cfd'
    412:
      id: 'weekend'
      doc: 'Wknd'
    413:
      id: 'single_day'
      doc: 'Singleday'
    414:
      id: 'custom_daily'
      doc: 'Custdaily'
    415:
      id: 'hourly'
      doc: 'Hourly'
    416:
      id: 'month'
      doc: 'Month'
    450:
      id: 'balweek'
      doc: 'Balwk'
    500:
      id: 'basket'
      doc: 'Kyoto'
    550:
      id: 'custom_monthly'
      doc: 'Custmonthly'
    600:
      id: 'next_week'
      doc: 'Nextwk'
    700:
      id: 'period'
      doc: 'Period'
    711:
      id: 'custom_daily_cfd'
      doc: 'Cust Daily Cfd'
    712:
      id: 'custom_daily_7_x_8'
      doc: 'Cust Daily 7 X 8'
    713:
      id: 'custom_daily_7_x_16'
      doc: 'Cust Daily 7 X 16'
    714:
      id: 'custom_daily_7_x_6'
      doc: 'Cust Daily 7 X 6'
    715:
      id: 'custom_daily_off_peak_x_16'
      doc: 'Cust Daily Opx 16'
    800:
      id: 'quarter'
      doc: 'Qtr'
    900:
      id: 'year'
      doc: 'Year'
  is_block_only:
    0x59:
      id: 'yes_field'
      doc: 'Only Tradable Via Ice Block Trade'
    0x4e:
      id: 'no_field'
      doc: 'Not Only Tradable Via Ice Block Trade'
  gt_allowed:
    0x59:
      id: 'yes_field'
      doc: 'Gtc Allowed'
    0x4e:
      id: 'no_field'
      doc: 'Gtc Not Allowed'
  mifid_regulated_market:
    0x59:
      id: 'yes_field'
      doc: 'Mifid 2 Market'
    0x4e:
      id: 'no_field'
      doc: 'Not Mifid 2 Marke'
  allow_options:
    0x59:
      id: 'yes_field'
      doc: 'Supports Option Markets'
    0x4e:
      id: 'no_field'
      doc: 'Does Not Support Option Markets'
  allows_implied:
    0x59:
      id: 'yes_field'
      doc: 'Implieds Are Allowed In This Market'
    0x4e:
      id: 'no_field'
      doc: 'Implieds Are Not Allowed In This Market'
  is_tradable:
    0x59:
      id: 'yes_field'
      doc: 'Indicates The Contract Is Tradable'
    0x4e:
      id: 'no_field'
      doc: 'Indicates The Contract Is Not Tradable'
  hedge_only:
    0x59:
      id: 'yes_field'
      doc: 'Hedge Only Contract'
    0x4e:
      id: 'no_field'
      doc: 'Not Hedge Only Contract'
  exchange_silo:
    0x30:
      id: 'ice'
      doc: 'Ice'
    0x31:
      id: 'endex'
      doc: 'Not Hedge Only Contract'
    0x32:
      id: 'liffe'
      doc: 'Liffe'
  test_market_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Test Market'
    0x4e:
      id: 'no_field'
      doc: 'Non Test Market'
  leg_deal_suppressed:
    0x59:
      id: 'yes_field'
      doc: 'Leg Deals Are Suppressed'
    0x4e:
      id: 'no_field'
      doc: 'Leg Deals Are Not Suppressed'
  market_type_id:
    0:
      id: 'financial_gas'
      doc: 'Financial Gas'
    1:
      id: 'financial_power'
      doc: 'Financial Power'
    2:
      id: 'oil'
      doc: 'Oil'
    3:
      id: 'ipe_natural_gas_futures'
      doc: 'Ipe Natural Gas Futures'
    4:
      id: 'ipe_gas_oil_futures'
      doc: 'Ipe Gas Oil Futures'
    5:
      id: 'ipe_brent_futures'
      doc: 'Ipe Brent Futures'
    7:
      id: 'ipe_uk_electricity_futures_peak'
      doc: 'Ipe Uk Electricity Futures Peak'
    8:
      id: 'ipe_uk_electricity_futures_base'
      doc: 'Ipe Uk Electricity Futures Base'
    9:
      id: 'ice_wti_crude_futures'
      doc: 'Ice Wti Crude Futures'
    10:
      id: 'g_c_newcastle_coal_futures'
      doc: 'G C Newcastle Coal Futures'
    11:
      id: 'ice_brent_wti_futures_spread'
      doc: 'Ice Brent Wti Futures Spread'
    12:
      id: 'ipeecx_european_emissions'
      doc: 'Ipeecx European Emissions'
    13:
      id: 'ice_heating_oil_futures'
      doc: 'Ice Heating Oil Futures'
    14:
      id: 'ice_heating_oil_wti_futures_crack'
      doc: 'Ice Heating Oil Wti Futures Crack'
    15:
      id: 'ice_nyh_rbob_gasoline_futures'
      doc: 'Ice Nyh Rbob Gasoline Futures'
    16:
      id: 'ice_nyh_rbob_gasoline_wti_futures_crack'
      doc: 'Ice Nyh Rbob Gasoline Wti Futures Crack'
    17:
      id: 'ice_rotterdam_coal_futures'
      doc: 'Ice Rotterdam Coal Futures'
    18:
      id: 'ice_richards_bay_coal_futures'
      doc: 'Ice Richards Bay Coal Futures'
    19:
      id: 'ice_rotterdam_richards_bay_coal_futures_spread'
      doc: 'Ice Rotterdam Richards Bay Coal Futures Spread'
    20:
      id: 'cocoa'
      doc: 'Cocoa'
    21:
      id: 'coffee_c'
      doc: 'Coffee C'
    22:
      id: 'cotton_no_2'
      doc: 'Cotton No 2'
    23:
      id: 'fcoj_a'
      doc: 'Fcoj A'
    24:
      id: 'sugar_no_11'
      doc: 'Sugar No 11'
    25:
      id: 'heat_rate_spread'
      doc: 'Heat Rate Spread'
    26:
      id: 'us_dollar_index'
      doc: 'Us Dollar Index'
    36:
      id: 'canadian_oilseeds'
      doc: 'Canadian Oilseeds'
    38:
      id: 'ecx_cer_futures'
      doc: 'Ecx Cer Futures'
    39:
      id: 'foreign_exchange'
      doc: 'Foreign Exchange'
    40:
      id: 'financial_index_data'
      doc: 'Financial Index Data'
    41:
      id: 'sugar_no_16'
      doc: 'Sugar No 16'
    42:
      id: 'ecx_euacer_futures_spread'
      doc: 'Ecx Euacer Futures Spread'
    44:
      id: 'henry_hub'
      doc: 'Henry Hub'
    48:
      id: 'dutch_ttf_gas_futures'
      doc: 'Dutch Ttf Gas Futures'
    50:
      id: 'german_natural_gas_futures'
      doc: 'German Natural Gas Futures'
    51:
      id: 'european_gas_spreads'
      doc: 'European Gas Spreads'
    53:
      id: 'canadian_financial_gas'
      doc: 'Canadian Financial Gas'
    54:
      id: 'ngx_canadian_physical_crude'
      doc: 'Ngx Canadian Physical Crude'
    55:
      id: 'us_coal_futures'
      doc: 'Us Coal Futures'
    57:
      id: 'fob_indo_subbit_coal_futures'
      doc: 'Fob Indo Subbit Coal Futures'
    58:
      id: 'heating_oil_brent_futures_crack'
      doc: 'Heating Oil Brent Futures Crack'
    59:
      id: 'nyh_rbob_gasoline_brent_futures_crack'
      doc: 'Nyh Rbob Gasoline Brent Futures Crack'
    60:
      id: 'wet_freight'
      doc: 'Wet Freight'
    61:
      id: 'dry_freight'
      doc: 'Dry Freight'
    62:
      id: 'ferrous_metals'
      doc: 'Ferrous Metals'
    63:
      id: 'platts_variable_oil'
      doc: 'Platts Variable Oil'
    66:
      id: 'nyh_rbob_gasoline_heating_oil_spread'
      doc: 'Nyh Rbob Gasoline Heating Oil Spread'
    69:
      id: 'physical_environmental'
      doc: 'Physical Environmental'
    70:
      id: 'heating_oil_ls_gasoil_futures_spread'
      doc: 'Heating Oil Ls Gasoil Futures Spread'
    71:
      id: 'ls_gasoil_brent_futures_crack'
      doc: 'Ls Gasoil Brent Futures Crack'
    72:
      id: 'nyh_rbob_gasoline_ls_gasoil_futures_spread'
      doc: 'Nyh Rbob Gasoline Ls Gasoil Futures Spread'
    84:
      id: 'ecx_euaa_futures'
      doc: 'Ecx Euaa Futures'
    85:
      id: 'ecx_cereuaa_futures_spread'
      doc: 'Ecx Cereuaa Futures Spread'
    86:
      id: 'ecx_euaaeua_futures_spread'
      doc: 'Ecx Euaaeua Futures Spread'
    89:
      id: 'soybean'
      doc: 'Soybean'
    92:
      id: 'ecx_eua_eib_auction'
      doc: 'Ecx Eua Eib Auction'
    93:
      id: 'financial_lng'
      doc: 'Financial Lng'
    95:
      id: 'eua_uk_auction'
      doc: 'Eua Uk Auction'
    96:
      id: 'euaa_uk_auction'
      doc: 'Euaa Uk Auction'
    97:
      id: 'cfr_south_china_coal_futures'
      doc: 'Cfr South China Coal Futures'
    98:
      id: 'belgian_power_futures'
      doc: 'Belgian Power Futures'
    99:
      id: 'dutch_power_futures'
      doc: 'Dutch Power Futures'
    100:
      id: 'g_c_newcastle_fob_indo_subbit_coal_futures_spread'
      doc: 'G C Newcastle Fob Indo Subbit Coal Futures Spread'
    101:
      id: 'richards_bayg_c_newcastle_coal_futures_spread'
      doc: 'Richards Bayg C Newcastle Coal Futures Spread'
    102:
      id: 'fcoj_a_mini'
      doc: 'Fcoj A Mini'
    104:
      id: 'cif_us'
      doc: 'Cif Us'
    108:
      id: 'd_6_rin'
      doc: 'D 6 Rin'
    111:
      id: 'european_power_spreads'
      doc: 'European Power Spreads'
    112:
      id: 'taqa'
      doc: 'Taqa'
    113:
      id: 'belgian_ztp_gas_spot'
      doc: 'Belgian Ztp Gas Spot'
    114:
      id: 'dutch_ttf_gas_spot'
      doc: 'Dutch Ttf Gas Spot'
    115:
      id: 'dutch_ttf_gas_storage'
      doc: 'Dutch Ttf Gas Storage'
    116:
      id: 'european_gas_spot_spreads'
      doc: 'European Gas Spot Spreads'
    117:
      id: 'belgian_ztp_gas_futures'
      doc: 'Belgian Ztp Gas Futures'
    118:
      id: 'uk_ocm_gas_spot'
      doc: 'Uk Ocm Gas Spot'
    119:
      id: 'belgian_gas_spreads'
      doc: 'Belgian Gas Spreads'
    124:
      id: 'financial_olefins'
      doc: 'Financial Olefins'
    125:
      id: 'financial_monomers'
      doc: 'Financial Monomers'
    126:
      id: 'platts_variable_oil_urals'
      doc: 'Platts Variable Oil Urals'
    127:
      id: 'endex_spot_market_indices'
      doc: 'Endex Spot Market Indices'
    131:
      id: 'interest_rate_futures'
      doc: 'Interest Rate Futures'
    133:
      id: 'singapore_energy'
      doc: 'Singapore Energy'
    134:
      id: 'singapore_financials'
      doc: 'Singapore Financials'
    135:
      id: 'singapore_metals'
      doc: 'Singapore Metals'
    136:
      id: 'italian_natural_gas_futures'
      doc: 'Italian Natural Gas Futures'
    137:
      id: 'italian_power_futures'
      doc: 'Italian Power Futures'
    139:
      id: 'credit_swap_data'
      doc: 'Credit Swap Data'
    140:
      id: 'gold_fixing'
      doc: 'Gold Fixing'
    141:
      id: 'north_sea_partials'
      doc: 'North Sea Partials'
    142:
      id: 'eu_financial_power_spreads'
      doc: 'Eu Financial Power Spreads'
    143:
      id: 'eu_financial_power_futures'
      doc: 'Eu Financial Power Futures'
    144:
      id: 'oil_cad'
      doc: 'Oil Cad'
    147:
      id: 'silver_fixing'
      doc: 'Silver Fixing'
    149:
      id: 'uk_spark_spread'
      doc: 'Uk Spark Spread'
    150:
      id: 'uk_ocm_physical_gas_spot'
      doc: 'Uk Ocm Physical Gas Spot'
    152:
      id: 'japan_domestic_waterborne'
      doc: 'Japan Domestic Waterborne'
    154:
      id: 'daily_metals'
      doc: 'Daily Metals'
    155:
      id: 'brix_energia_fin'
      doc: 'Brix Energia Fin'
    156:
      id: 'japan_domestic_rack'
      doc: 'Japan Domestic Rack'
    157:
      id: 'financial_us_lng'
      doc: 'Financial Us Lng'
    160:
      id: 'ice_rotterdam_newcastle_coal_futures_spread'
      doc: 'Ice Rotterdam Newcastle Coal Futures Spread'
    165:
      id: 'oil_americas'
      doc: 'Oil Americas'
    167:
      id: 'platts_petrochemical'
      doc: 'Platts Petrochemical'
    168:
      id: 'permian_wti_futures'
      doc: 'Permian Wti Futures'
    170:
      id: 'endex_equity_indices'
      doc: 'Endex Equity Indices'
    171:
      id: 'endex_single_stock_options'
      doc: 'Endex Single Stock Options'
    172:
      id: 'ifus_ice_indices'
      doc: 'Ifus Ice Indices'
    173:
      id: 'platts_asia_bunker'
      doc: 'Platts Asia Bunker'
    177:
      id: 'sofr_futures'
      doc: 'Sofr Futures'
    178:
      id: 'digital_asset_futures'
      doc: 'Digital Asset Futures'
    179:
      id: 'permian_brent_futures_spread'
      doc: 'Permian Brent Futures Spread'
    180:
      id: 'permian_wti_futures_spread'
      doc: 'Permian Wti Futures Spread'
    200:
      id: 'liffe_sti_rs'
      doc: 'Liffe Sti Rs'
    202:
      id: 'liffe_bonds'
      doc: 'Liffe Bonds'
    203:
      id: 'liffe_swapnotes'
      doc: 'Liffe Swapnotes'
    205:
      id: 'liffe_commodities'
      doc: 'Liffe Commodities'
    206:
      id: 'metals'
      doc: 'Metals'
    207:
      id: 'ifus_equity_indices'
      doc: 'Ifus Equity Indices'
    208:
      id: 'gcf_repo'
      doc: 'Gcf Repo'
    209:
      id: 'liffe_three_month_euro_and_eonia'
      doc: 'Liffe Three Month Euro And Eonia'
    210:
      id: 'eurodollar'
      doc: 'Eurodollar'
    211:
      id: 'liffe_equity_derivatives_non_us_based'
      doc: 'Liffe Equity Derivatives Non Us Based'
    212:
      id: 'liffe_equity_derivatives_us_based'
      doc: 'Liffe Equity Derivatives Us Based'
    213:
      id: 'liffe_index_options'
      doc: 'Liffe Index Options'
    214:
      id: 'liffe_index_futures_us_restricted'
      doc: 'Liffe Index Futures Us Restricted'
    215:
      id: 'liffe_index_futures_non_us_restricted'
      doc: 'Liffe Index Futures Non Us Restricted'
    305:
      id: 'physical_gas'
      doc: 'Physical Gas'
    306:
      id: 'power'
      doc: 'Power'
    314:
      id: 'ngx_physical_gas'
      doc: 'Ngx Physical Gas'
    315:
      id: 'ngx_financial_power'
      doc: 'Ngx Financial Power'
    316:
      id: 'ngx_financial_gas'
      doc: 'Ngx Financial Gas'
    317:
      id: 'financial_ngl'
      doc: 'Financial Ngl'
    318:
      id: 'olefins_polymers'
      doc: 'Olefins Polymers'
    319:
      id: 'physical_ngl'
      doc: 'Physical Ngl'
    320:
      id: 'physical_oil'
      doc: 'Physical Oil'
    600:
      id: 'test_ipe'
      doc: 'Test Ipe'
    601:
      id: 'test_nybot'
      doc: 'Test Nybot'
    602:
      id: 'test_ndex'
      doc: 'Test Ndex'
    603:
      id: 'test_liffeuk_1'
      doc: 'Test Liffeuk 1'
    604:
      id: 'test_liffeuk_2'
      doc: 'Test Liffeuk 2'
  settlement_type:
    0x30:
      id: 'financial'
      doc: 'Financial'
    0x31:
      id: 'physical'
      doc: 'Physical'
  cross_order_supported:
    0x59:
      id: 'yes_field'
      doc: 'Cross Order Is Supported'
    0x4e:
      id: 'no_field'
      doc: 'Cross Order Is Not Supported'
  special_field_id:
    1:
      id: 'alt_price'
      doc: 'Eris Futures Price'
    2:
      id: 'alt_high_price'
      doc: 'High Eris Futures Price'
    3:
      id: 'alt_low_price'
      doc: 'Low Eris Futures Price'
    4:
      id: 'alt_vwap'
      doc: 'Volume-weighted Average Eris Futures Price'
    5:
      id: 'alt_last_trade_price'
      doc: 'Last Trade Eris Futures Price'
    6:
      id: 'aon'
      doc: 'Order is All-Or-None'
  side:
    0x20:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'bid'
      doc: 'Bid'
    0x32:
      id: 'offer'
      doc: 'Offer'
  start_or_end:
    0x53:
      id: 'start'
      doc: 'Start Of A Message Bundle'
    0x45:
      id: 'end'
      doc: 'End Of A Message Bundle'
  is_balanced:
    0x59:
      id: 'yes_field'
      doc: 'Balanced'
    0x4e:
      id: 'no_field'
      doc: 'Not Balanced'
  is_final:
    0x59:
      id: 'yes_field'
      doc: 'Final'
    0x4e:
      id: 'no_field'
      doc: 'Final'
  hedge_side:
    0x20:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'bid'
      doc: 'Bid'
    0x32:
      id: 'offer'
      doc: 'Offer'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
  options_style:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
    0x30:
      id: 'none'
      doc: 'None'
    0x33:
      id: 'asian'
      doc: 'Asian'
    0x34:
      id: 'one_time'
      doc: 'One Time'
  options_expiration_type:
    0x4d:
      id: 'monthly'
      doc: 'Monthly'
    0x44:
      id: 'daily'
      doc: 'Daily'
  guaranteed_cross_supported:
    0x59:
      id: 'yes_field'
      doc: 'Guaranteed Cross Supported'
    0x4e:
      id: 'no_field'
      doc: 'Guaranteed Cross Not Supported'
  event_code:
    0x30:
      id: 'normal_trade'
      doc: 'Normal Trade'
    0x31:
      id: 'cancelled_trade'
      doc: 'Cancelled Trade'
    0x32:
      id: 'adjusted_trade'
      doc: 'Adjusted Trade'

