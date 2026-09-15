# ---------------------------------------------------------------------
# Kaitai struct definition for: Ice IceFutures Bgw Sbe v7.0
#
# Protocol:
#   Organization: Intercontinental Exchange
#   Protocol: Binary Order Gateway
#   Encoding: Simple Binary Encoding
#   Version: 7.0
#   Date: 10/24/2025
#   Specification: ICE Binary Order and Utility Service API Message Specification - Version 2.6.3 - Final - 10.24.2025.pdf
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
  id: ice_icefutures_bgw_sbe_v7_0
  title: Ice IceFutures Bgw Sbe v7.0
  license: GPL-3.0
  endian: le

doc: 'Intercontinental Exchange Intercontinental Exchange Futures Binary Order Gateway Sbe v7.0'
doc-ref: https://service.ice.com/s/article/Binary-Order-API

seq:
  - id: simple_open_frame
    type: simple_open_frame_struct
    repeat: eos
    doc: 'Simple Open Frame'

types:
  simple_open_frame_struct:
    seq:
      - id: simple_open_framing_header
        type: simple_open_framing_header
        doc: 'Simple Open Framing Header'
      - id: message_header
        type: message_header
        doc: 'Ice Binary Order Gateway Sbe message header'
      - id: payload
        size: simple_open_framing_header.message_length - 21
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::simple_open_framing_header_message': simple_open_framing_header_message
            'template_id::logon_request_message': logon_request_message
            'template_id::logon_report_message': logon_report_message
            'template_id::logout_request_message': logout_request_message
            'template_id::logout_report_message': logout_report_message
            'template_id::error_message': error_message
            'template_id::news_message': news_message
            'template_id::security_definition_report_strategy_message': security_definition_report_strategy_message
            'template_id::security_definition_report_message': security_definition_report_message
            'template_id::security_definition_reject_message': security_definition_reject_message
            'template_id::security_definition_request_message': security_definition_request_message
            'template_id::security_definition_report_product_message': security_definition_report_product_message
            'template_id::ip_request_message': ip_request_message
            'template_id::ip_report_message': ip_report_message
            'template_id::trader_logon_request_message': trader_logon_request_message
            'template_id::trader_logon_report_message': trader_logon_report_message
            'template_id::trader_logout_request_message': trader_logout_request_message
            'template_id::trader_logout_report_message': trader_logout_report_message
            'template_id::new_order_request_message': new_order_request_message
            'template_id::cancel_replace_request_message': cancel_replace_request_message
            'template_id::cancel_request_message': cancel_request_message
            'template_id::quote_request_message': quote_request_message
            'template_id::new_order_cross_request_message': new_order_cross_request_message
            'template_id::order_mass_cancel_request_message': order_mass_cancel_request_message
            'template_id::mass_quote_request_message': mass_quote_request_message
            'template_id::quote_cancel_request_message': quote_cancel_request_message
            'template_id::security_definition_request_create_strategy_message': security_definition_request_create_strategy_message
            'template_id::security_definition_request_create_flex_message': security_definition_request_create_flex_message
            'template_id::execution_report_new_message': execution_report_new_message
            'template_id::execution_report_modify_message': execution_report_modify_message
            'template_id::execution_report_cancel_message': execution_report_cancel_message
            'template_id::execution_report_reject_message': execution_report_reject_message
            'template_id::execution_report_snapshot_message': execution_report_snapshot_message
            'template_id::execution_report_trade_message': execution_report_trade_message
            'template_id::quote_report_message': quote_report_message
            'template_id::new_order_cross_report_message': new_order_cross_report_message
            'template_id::order_mass_cancel_report_message': order_mass_cancel_report_message
            'template_id::mass_quote_report_message': mass_quote_report_message
            'template_id::resend_request_message': resend_request_message
            'template_id::resend_report_message': resend_report_message
            'template_id::sequence_reset_message': sequence_reset_message
  simple_open_framing_header:
    seq:
      - id: message_length
        type: u2
        doc: 'messageLength'
      - id: encoding_type
        type: u2
        doc: 'encodingType'
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
      - id: sequence_id
        type: u4
        doc: 'Outbound sequence number assigned per Bgw session, reset to 1 at the start of each trading session'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'UTC timestamp of when the message was sent, nanoseconds since Unix epoch (January 1st, 1970, 00:00:00 GMT). Nanoseconds since Unix epoch'
      - id: header_flags
        type: header_flags
        doc: 'Uint8 bit set carrying possDupe and possResend indicators'
  header_flags:
    meta:
      bit-endian: le
    seq:
      - id: poss_dupe
        type: b1
        doc: 'possDupe'
      - id: poss_resend
        type: b1
        doc: 'possResend'
      - id: reserved_bits
        type: b6
        doc: 'Bits reserved for future use'
  simple_open_framing_header_message:
    seq:
      - id: framing_header
        type: framing_header
        doc: 'SimpleOpenFramingHeaderMessage'
  framing_header:
    seq:
      - id: message_length
        type: u2
        doc: 'messageLength'
      - id: encoding_type
        type: u2
        doc: 'encodingType'
  logon_request_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
      - id: client_id
        type: s4
        doc: 'clientID'
      - id: heart_beat_interval
        type: u2
        doc: 'heartBeatInterval'
      - id: application_name
        type: str
        size: 30
        encoding: ASCII
        doc: 'applicationName'
      - id: application_version
        type: str
        size: 50
        encoding: ASCII
        doc: 'applicationVersion'
      - id: application_vendor
        type: str
        size: 30
        encoding: ASCII
        doc: 'applicationVendor'
      - id: raw_data
        type: str
        size: 50
        encoding: ASCII
        doc: 'rawData'
      - id: ip_session_token
        type: str
        size: 50
        encoding: ASCII
        doc: 'ipSessionToken'
  logon_report_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
      - id: heart_beat_interval
        type: u2
        doc: 'heartBeatInterval'
      - id: severity_level
        type: u1
        enum: severity_level
        doc: 'severityLevel'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  logout_request_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
  logout_report_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  error_message:
    seq:
      - id: ref_sequence_id
        type: u4
        doc: 'refSequenceId'
      - id: severity_level
        type: u1
        enum: severity_level
        doc: 'severityLevel'
      - id: supported_schema_version
        type: str
        size: 20
        encoding: ASCII
        doc: 'supportedSchemaVersion'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  news_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text_var_string_16_null
        type: text_var_string_16_null
        doc: 'text data struct'
  text_var_string_16_null:
    seq:
      - id: len_text_data
        type: u2
      - id: text_data
        size: len_text_data
        if: len_text_data > 0
  security_definition_report_strategy_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'securityResponseType'
      - id: security_response_id
        type: s4
        doc: 'securityResponseID'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: no_rpts
        type: s4
        doc: 'noRpts'
      - id: list_seq_no
        type: s4
        doc: 'listSeqNo'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: underlying_strategy_symbol
        type: s4
        doc: 'underlyingStrategySymbol'
      - id: maturity_date
        type: u2
        doc: 'maturityDate'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'securityTradingStatus'
      - id: security_sub_type_int_16
        type: s2
        doc: 'securitySubType'
      - id: exchange_silo
        type: u1
        enum: exchange_silo
        doc: 'exchangeSilo'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: leg_deals_suppressed
        type: u1
        enum: leg_deals_suppressed
        doc: 'legDealsSuppressed'
      - id: increment_price
        type: s8
        doc: 'incrementPrice'
      - id: increment_qty
        type: s8
        doc: 'incrementQty'
      - id: min_price
        type: s8
        doc: 'minPrice'
      - id: max_price
        type: s8
        doc: 'maxPrice'
      - id: num_of_decimal_price
        type: s1
        doc: 'numOfDecimalPrice'
      - id: num_of_decimal_qty
        type: s1
        doc: 'numOfDecimalQty'
      - id: product_i_d_int_32
        type: s4
        doc: 'productID'
      - id: base_num_lots
        type: s4
        doc: 'baseNumLots'
      - id: denominator
        type: s4
        doc: 'denominator'
      - id: implied_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'impliedType'
      - id: off_exchange_increment_price_decimal_9_null
        type: s8
        doc: 'offExchangeIncrementPrice'
      - id: off_exchange_increment_qty_decimal_9_null
        type: s8
        doc: 'offExchangeIncrementQty'
      - id: num_of_decimal_strike_price
        type: s1
        doc: 'numOfDecimalStrikePrice'
      - id: num_of_cycles_int_16_null
        type: s2
        doc: 'numOfCycles'
      - id: lot_size_multiplier_decimal_9_null
        type: s8
        doc: 'lotSizeMultiplier'
      - id: block_only
        type: u1
        enum: block_only
        doc: 'blockOnly'
      - id: flex_allowed
        type: u1
        enum: flex_allowed
        doc: 'flexAllowed'
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'gtAllowed'
      - id: mifid_regulated_market_boolean_enum
        type: u1
        enum: mifid_regulated_market_boolean_enum
        doc: 'mifidRegulatedMarket'
      - id: strip_type
        type: s2
        doc: 'stripType'
      - id: hub_id
        type: s4
        doc: 'hubID'
      - id: override_block_min
        type: u1
        enum: override_block_min
        doc: 'overrideBlockMin'
      - id: test_market_indicator_boolean_enum
        type: u1
        enum: test_market_indicator_boolean_enum
        doc: 'testMarketIndicator'
      - id: screen_tick_value
        type: s8
        doc: 'screenTickValue'
      - id: block_tick_value
        type: s8
        doc: 'blockTickValue'
      - id: security_definition_report_strategy_message_no_block_details_groups
        type: security_definition_report_strategy_message_no_block_details_groups
        doc: 'noBlockDetails Block'
      - id: security_definition_report_strategy_message_no_security_alt_i_d_groups
        type: security_definition_report_strategy_message_no_security_alt_i_d_groups
        doc: 'noSecurityAltID Block'
      - id: security_definition_report_strategy_message_no_legs_groups
        type: security_definition_report_strategy_message_no_legs_groups
        doc: 'noLegs Block'
      - id: security_id
        type: security_id
        doc: 'securityID data struct'
      - id: unit_of_measure
        type: unit_of_measure
        doc: 'unitOfMeasure data struct'
      - id: price_denomination
        type: price_denomination
        doc: 'priceDenomination data struct'
      - id: cleared_alias
        type: cleared_alias
        doc: 'clearedAlias data struct'
      - id: security_desc
        type: security_desc
        doc: 'securityDesc data struct'
      - id: price_unit
        type: price_unit
        doc: 'priceUnit data struct'
      - id: strip_name
        type: strip_name
        doc: 'stripName data struct'
      - id: hub_name
        type: hub_name
        doc: 'hubName data struct'
      - id: hub_alias
        type: hub_alias
        doc: 'hubAlias data struct'
      - id: security_exchange
        type: security_exchange
        doc: 'securityExchange data struct'
      - id: strategy_security_id
        type: strategy_security_id
        doc: 'strategySecurityID data struct'
      - id: physical_code
        type: physical_code
        doc: 'physicalCode data struct'
  security_definition_report_strategy_message_no_block_details_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_report_strategy_message_no_block_details_group
        type: security_definition_report_strategy_message_no_block_details_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noBlockDetails'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u2
        doc: 'numInGroup'
  security_definition_report_strategy_message_no_block_details_group:
    seq:
      - id: block_details_block_type
        type: u1
        enum: block_details_block_type
        doc: 'blockDetailsBlockType'
      - id: block_details_trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'blockDetailsTradeType'
      - id: block_details_min_qty
        type: s8
        doc: 'blockDetailsMinQty'
  security_definition_report_strategy_message_no_security_alt_i_d_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_report_strategy_message_no_security_alt_i_d_group
        type: security_definition_report_strategy_message_no_security_alt_i_d_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noSecurityAltID'
  security_definition_report_strategy_message_no_security_alt_i_d_group:
    seq:
      - id: security_alt_id
        type: str
        size: 30
        encoding: ASCII
        doc: 'ISIN of equity related market if securityAltIDSource is 4 or as required by MiFID if securityAltIDSource is U4'
      - id: security_alt_id_source
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityAltIDSource'
  security_definition_report_strategy_message_no_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_report_strategy_message_no_legs_group
        type: security_definition_report_strategy_message_no_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noLegs'
  security_definition_report_strategy_message_no_legs_group:
    seq:
      - id: leg_symbol_int_32
        type: s4
        doc: 'legSymbol'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'legSecurityType'
      - id: leg_security_sub_type
        type: s2
        doc: 'legSecuritySubType'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'legSide'
      - id: leg_price
        type: s8
        doc: 'Required if legSecurityType is FUT'
      - id: leg_option_delta
        type: s4
        doc: 'Required if legSecurityType is FUT or CS'
      - id: leg_ratio_qty_denominator_int_16
        type: s2
        doc: 'legRatioQtyDenominator'
      - id: leg_ratio_qty_numerator_int_16
        type: s2
        doc: 'legRatioQtyNumerator'
      - id: leg_ratio_price_denominator
        type: s2
        doc: 'legRatioPriceDenominator'
      - id: leg_ratio_price_numerator
        type: s2
        doc: 'legRatioPriceNumerator'
  security_id:
    seq:
      - id: len_security_id_data
        type: u2
      - id: security_id_data
        size: len_security_id_data
        if: len_security_id_data > 0
  unit_of_measure:
    seq:
      - id: len_unit_of_measure_data
        type: u2
      - id: unit_of_measure_data
        size: len_unit_of_measure_data
        if: len_unit_of_measure_data > 0
  price_denomination:
    seq:
      - id: len_price_denomination_data
        type: u2
      - id: price_denomination_data
        size: len_price_denomination_data
        if: len_price_denomination_data > 0
  cleared_alias:
    seq:
      - id: len_cleared_alias_data
        type: u2
      - id: cleared_alias_data
        size: len_cleared_alias_data
        if: len_cleared_alias_data > 0
  security_desc:
    seq:
      - id: len_security_desc_data
        type: u2
      - id: security_desc_data
        size: len_security_desc_data
        if: len_security_desc_data > 0
  price_unit:
    seq:
      - id: len_price_unit_data
        type: u2
      - id: price_unit_data
        size: len_price_unit_data
        if: len_price_unit_data > 0
  strip_name:
    seq:
      - id: len_strip_name_data
        type: u2
      - id: strip_name_data
        size: len_strip_name_data
        if: len_strip_name_data > 0
  hub_name:
    seq:
      - id: len_hub_name_data
        type: u2
      - id: hub_name_data
        size: len_hub_name_data
        if: len_hub_name_data > 0
  hub_alias:
    seq:
      - id: len_hub_alias_data
        type: u2
      - id: hub_alias_data
        size: len_hub_alias_data
        if: len_hub_alias_data > 0
  security_exchange:
    seq:
      - id: len_security_exchange_data
        type: u2
      - id: security_exchange_data
        size: len_security_exchange_data
        if: len_security_exchange_data > 0
  strategy_security_id:
    seq:
      - id: len_strategy_security_id_data
        type: u2
      - id: strategy_security_id_data
        size: len_strategy_security_id_data
        if: len_strategy_security_id_data > 0
  physical_code:
    seq:
      - id: len_physical_code_data
        type: u2
      - id: physical_code_data
        size: len_physical_code_data
        if: len_physical_code_data > 0
  security_definition_report_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'securityResponseType'
      - id: security_response_id
        type: s4
        doc: 'securityResponseID'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: exchange_silo
        type: u1
        enum: exchange_silo
        doc: 'exchangeSilo'
      - id: no_rpts
        type: s4
        doc: 'noRpts'
      - id: list_seq_no
        type: s4
        doc: 'listSeqNo'
      - id: underlying_symbol_int_32
        type: s4
        doc: 'underlyingSymbol'
      - id: cfi_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'cfiCode'
      - id: security_sub_type_int_16_null
        type: s2
        doc: 'securitySubType'
      - id: maturity_date
        type: u2
        doc: 'maturityDate'
      - id: screen_last_trade_date
        type: u2
        doc: 'screenLastTradeDate'
      - id: contract_multiplier
        type: s4
        doc: 'contractMultiplier'
      - id: start_date
        type: u2
        doc: 'startDate'
      - id: end_date
        type: u2
        doc: 'endDate'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'putOrCall'
      - id: strike_price
        type: s8
        doc: 'strikePrice'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'securityTradingStatus'
      - id: currency
        type: str
        size: 12
        encoding: ASCII
        doc: 'currency'
      - id: settl_method
        type: u1
        enum: settl_method
        doc: 'settlMethod'
      - id: strike_exercise_style
        type: u1
        enum: strike_exercise_style
        doc: 'strikeExerciseStyle'
      - id: increment_qty
        type: s8
        doc: 'incrementQty'
      - id: increment_price
        type: s8
        doc: 'incrementPrice'
      - id: min_price
        type: s8
        doc: 'minPrice'
      - id: max_price
        type: s8
        doc: 'maxPrice'
      - id: off_exchange_increment_price_decimal_9
        type: s8
        doc: 'offExchangeIncrementPrice'
      - id: off_exchange_increment_qty_decimal_9
        type: s8
        doc: 'offExchangeIncrementQty'
      - id: screen_tick_value
        type: s8
        doc: 'screenTickValue'
      - id: block_tick_value
        type: s8
        doc: 'blockTickValue'
      - id: lot_size
        type: s4
        doc: 'lotSize'
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: num_of_decimal_price
        type: s1
        doc: 'numOfDecimalPrice'
      - id: num_of_decimal_qty
        type: s1
        doc: 'numOfDecimalQty'
      - id: granularity
        type: str
        size: 12
        encoding: ASCII
        doc: 'granularity'
      - id: base_num_lots
        type: s4
        doc: 'baseNumLots'
      - id: tick_value
        type: s8
        doc: 'tickValue'
      - id: product_i_d_int_32
        type: s4
        doc: 'productID'
      - id: clearable
        type: u1
        enum: clearable
        doc: 'clearable'
      - id: hedge_product_id
        type: s4
        doc: 'hedgeProductID'
      - id: hedge_market_id
        type: s4
        doc: 'hedgeMarketID'
      - id: hedge_only
        type: u1
        enum: hedge_only
        doc: 'hedgeOnly'
      - id: is_dividend_adjusted
        type: u1
        enum: is_dividend_adjusted
        doc: 'isDividendAdjusted'
      - id: denominator
        type: s4
        doc: 'denominator'
      - id: initial_margin
        type: s4
        doc: 'initialMargin'
      - id: implied_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'impliedType'
      - id: num_of_decimal_strike_price
        type: s1
        doc: 'numOfDecimalStrikePrice'
      - id: num_of_cycles_int_16
        type: s2
        doc: 'numOfCycles'
      - id: lot_size_multiplier_decimal_9
        type: s8
        doc: 'lotSizeMultiplier'
      - id: strip_type
        type: s2
        doc: 'stripType'
      - id: strip_id
        type: s4
        doc: 'stripID'
      - id: block_only
        type: u1
        enum: block_only
        doc: 'blockOnly'
      - id: flex_allowed
        type: u1
        enum: flex_allowed
        doc: 'flexAllowed'
      - id: gt_allowed
        type: u1
        enum: gt_allowed
        doc: 'gtAllowed'
      - id: aon_allowed
        type: u1
        enum: aon_allowed
        doc: 'aonAllowed'
      - id: mifid_regulated_market_boolean_enum_null
        type: u1
        enum: mifid_regulated_market_boolean_enum_null
        doc: 'mifidRegulatedMarket'
      - id: flex_strike_allowed
        type: u1
        enum: flex_strike_allowed
        doc: 'flexStrikeAllowed'
      - id: hub_id
        type: s4
        doc: 'hubID'
      - id: override_block_min
        type: u1
        enum: override_block_min
        doc: 'overrideBlockMin'
      - id: test_market_indicator_boolean_enum_null
        type: u1
        enum: test_market_indicator_boolean_enum_null
        doc: 'testMarketIndicator'
      - id: ref_sprd_product_id
        type: s4
        doc: 'refSprdProductID'
      - id: market_transparency_type
        type: u1
        enum: market_transparency_type
        doc: 'marketTransparencyType'
      - id: non_commoditized_market
        type: u1
        enum: non_commoditized_market
        doc: 'nonCommoditizedMarket'
      - id: security_definition_report_message_no_block_details_groups
        type: security_definition_report_message_no_block_details_groups
        doc: 'noBlockDetails Block'
      - id: security_definition_report_message_no_security_alt_i_d_groups
        type: security_definition_report_message_no_security_alt_i_d_groups
        doc: 'noSecurityAltID Block'
      - id: security_id
        type: security_id
        doc: 'securityID data struct'
      - id: unit_of_measure
        type: unit_of_measure
        doc: 'unitOfMeasure data struct'
      - id: price_denomination
        type: price_denomination
        doc: 'priceDenomination data struct'
      - id: cleared_alias
        type: cleared_alias
        doc: 'clearedAlias data struct'
      - id: security_desc
        type: security_desc
        doc: 'securityDesc data struct'
      - id: price_unit
        type: price_unit
        doc: 'priceUnit data struct'
      - id: strip_name
        type: strip_name
        doc: 'stripName data struct'
      - id: hub_name
        type: hub_name
        doc: 'hubName data struct'
      - id: hub_alias
        type: hub_alias
        doc: 'hubAlias data struct'
      - id: security_exchange
        type: security_exchange
        doc: 'securityExchange data struct'
      - id: physical_code
        type: physical_code
        doc: 'physicalCode data struct'
      - id: home_exchange
        type: home_exchange
        doc: 'homeExchange data struct'
  security_definition_report_message_no_block_details_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_report_message_no_block_details_group
        type: security_definition_report_message_no_block_details_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noBlockDetails'
  security_definition_report_message_no_block_details_group:
    seq:
      - id: block_details_block_type
        type: u1
        enum: block_details_block_type
        doc: 'blockDetailsBlockType'
      - id: block_details_trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'blockDetailsTradeType'
      - id: block_details_min_qty
        type: s8
        doc: 'blockDetailsMinQty'
  security_definition_report_message_no_security_alt_i_d_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_report_message_no_security_alt_i_d_group
        type: security_definition_report_message_no_security_alt_i_d_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noSecurityAltID'
  security_definition_report_message_no_security_alt_i_d_group:
    seq:
      - id: security_alt_id
        type: str
        size: 30
        encoding: ASCII
        doc: 'ISIN of equity related market if securityAltIDSource is 4 or as required by MiFID if securityAltIDSource is U4'
      - id: security_alt_id_source
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityAltIDSource'
  home_exchange:
    seq:
      - id: len_home_exchange_data
        type: u2
      - id: home_exchange_data
        size: len_home_exchange_data
        if: len_home_exchange_data > 0
  security_definition_reject_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'securityResponseType'
      - id: security_request_type
        type: u1
        enum: security_request_type
        doc: 'securityRequestType'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: security_type_security_type_enum_null
        type: u1
        enum: security_type_security_type_enum_null
        doc: 'securityType'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  security_definition_request_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_request_type
        type: u1
        enum: security_request_type
        doc: 'securityRequestType'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
  security_definition_report_product_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'securityResponseType'
      - id: security_response_id
        type: s4
        doc: 'securityResponseID'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: no_rpts
        type: s4
        doc: 'noRpts'
      - id: list_seq_no
        type: s4
        doc: 'listSeqNo'
      - id: product_i_d_int_32
        type: s4
        doc: 'productID'
      - id: product_type
        type: str
        size: 12
        encoding: ASCII
        doc: 'productType'
      - id: mifid_regulated_market_boolean_enum
        type: u1
        enum: mifid_regulated_market_boolean_enum
        doc: 'mifidRegulatedMarket'
      - id: test_market_indicator_boolean_enum
        type: u1
        enum: test_market_indicator_boolean_enum
        doc: 'testMarketIndicator'
      - id: stops_allowed
        type: u1
        enum: stops_allowed
        doc: 'stopsAllowed'
      - id: options_allowed
        type: u1
        enum: options_allowed
        doc: 'optionsAllowed'
      - id: uds_options_allowed
        type: u1
        enum: uds_options_allowed
        doc: 'udsOptionsAllowed'
      - id: uds_futures_allowed
        type: u1
        enum: uds_futures_allowed
        doc: 'udsFuturesAllowed'
      - id: mass_quotes_allowed
        type: u1
        enum: mass_quotes_allowed
        doc: 'massQuotesAllowed'
      - id: rfq_futures_allowed
        type: u1
        enum: rfq_futures_allowed
        doc: 'rfqFuturesAllowed'
      - id: rfq_options_allowed
        type: u1
        enum: rfq_options_allowed
        doc: 'rfqOptionsAllowed'
      - id: crossing_order_futures_allowed
        type: u1
        enum: crossing_order_futures_allowed
        doc: 'crossingOrderFuturesAllowed'
      - id: crossing_order_options_allowed
        type: u1
        enum: crossing_order_options_allowed
        doc: 'crossingOrderOptionsAllowed'
      - id: self_block_allowed
        type: u1
        enum: self_block_allowed
        doc: 'selfBlockAllowed'
      - id: product_name
        type: product_name
        doc: 'productName data struct'
      - id: product_desc
        type: product_desc
        doc: 'productDesc data struct'
      - id: product_group
        type: product_group
        doc: 'productGroup data struct'
  product_name:
    seq:
      - id: len_product_name_data
        type: u2
      - id: product_name_data
        size: len_product_name_data
        if: len_product_name_data > 0
  product_desc:
    seq:
      - id: len_product_desc_data
        type: u2
      - id: product_desc_data
        size: len_product_desc_data
        if: len_product_desc_data > 0
  product_group:
    seq:
      - id: len_product_group_data
        type: u2
      - id: product_group_data
        size: len_product_group_data
        if: len_product_group_data > 0
  ip_request_message:
    seq:
      - id: client_id
        type: s4
        doc: 'clientID'
      - id: i_p_request_message_no_users_groups
        type: i_p_request_message_no_users_groups
        doc: 'noUsers Block'
  i_p_request_message_no_users_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: i_p_request_message_no_users_group
        type: i_p_request_message_no_users_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noUsers'
  i_p_request_message_no_users_group:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
  ip_report_message:
    seq:
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
      - id: i_p_report_message_no_users_groups
        type: i_p_report_message_no_users_groups
        doc: 'noUsers Block'
  i_p_report_message_no_users_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: i_p_report_message_no_users_group
        type: i_p_report_message_no_users_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noUsers'
  i_p_report_message_no_users_group:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'userID'
      - id: success
        type: u1
        enum: success
        doc: 'success'
      - id: ip_address
        type: str
        size: 15
        encoding: ASCII
        doc: 'ipAddress'
      - id: port
        type: s2
        doc: 'port'
      - id: ip_session_token
        type: str
        size: 50
        encoding: ASCII
        doc: 'ipSessionToken'
  trader_logon_request_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: raw_data
        type: str
        size: 50
        encoding: ASCII
        doc: 'rawData'
  trader_logon_report_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: client_id
        type: s4
        doc: 'clientID'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  trader_logout_request_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
  trader_logout_report_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  new_order_request_message:
    seq:
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: order_qty_decimal_9
        type: s8
        doc: 'orderQty'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: time_in_force_time_in_force_enum
        type: u1
        enum: time_in_force_time_in_force_enum
        doc: 'timeInForce'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'manualOrderIndicator'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: max_show
        type: s8
        doc: 'maxShow'
      - id: stop_px
        type: s8
        doc: 'stopPx'
      - id: give_up_clearing_firm
        type: s4
        doc: 'giveUpClearingFirm'
      - id: clearing_firm_int_32
        type: s4
        doc: 'clearingFirm'
      - id: self_match_prevention_id
        type: s8
        doc: 'selfMatchPreventionID'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'selfMatchPreventionInstruction'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'execInst'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'custOrderHandlingInst'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'positionEffect'
      - id: alloc_handl_inst
        type: u1
        enum: alloc_handl_inst
        doc: 'allocHandlInst'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'priceType'
      - id: clearing_account_string_14
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: customer_account_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'customerAccountRefID'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: allocation_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'allocationAccount'
      - id: on_behalf_of_comp_id
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfCompId'
      - id: on_behalf_of_sub_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
      - id: on_behalf_of_location_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfLocationID'
  cancel_replace_request_message:
    seq:
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: order_qty_decimal_9
        type: s8
        doc: 'orderQty'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: time_in_force_time_in_force_enum
        type: u1
        enum: time_in_force_time_in_force_enum
        doc: 'timeInForce'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'manualOrderIndicator'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: orig_cl_ord_i_d_int_64
        type: s8
        doc: 'origClOrdID'
      - id: max_show
        type: s8
        doc: 'maxShow'
      - id: stop_px
        type: s8
        doc: 'stopPx'
      - id: give_up_clearing_firm
        type: s4
        doc: 'giveUpClearingFirm'
      - id: clearing_firm_int_32
        type: s4
        doc: 'clearingFirm'
      - id: self_match_prevention_id
        type: s8
        doc: 'selfMatchPreventionID'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'selfMatchPreventionInstruction'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'execInst'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: alloc_handl_inst
        type: u1
        enum: alloc_handl_inst
        doc: 'allocHandlInst'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'priceType'
      - id: clearing_account_string_14
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: customer_account_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'customerAccountRefID'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: allocation_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'allocationAccount'
      - id: on_behalf_of_comp_id
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfCompId'
      - id: on_behalf_of_sub_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
      - id: on_behalf_of_location_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfLocationID'
  cancel_request_message:
    seq:
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: orig_cl_ord_i_d_int_64
        type: s8
        doc: 'origClOrdID'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
  quote_request_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: side_side_enum_null
        type: u1
        enum: side_side_enum_null
        doc: 'side'
      - id: order_qty_decimal_9_null
        type: s8
        doc: 'orderQty'
      - id: rfq_req_id
        type: s8
        doc: 'rfqReqID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: clearing_firm_int_32_null
        type: s4
        doc: 'clearingFirm'
      - id: clearing_account_string_14_null
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: on_behalf_of_comp_id
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfCompId'
      - id: on_behalf_of_sub_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
      - id: on_behalf_of_location_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfLocationID'
  new_order_cross_request_message:
    seq:
      - id: price_decimal_9
        type: s8
        doc: 'price'
      - id: order_qty_decimal_9
        type: s8
        doc: 'orderQty'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: cross_i_d_int_64
        type: s8
        doc: 'crossID'
      - id: cross_type_cross_type_enum
        type: u1
        enum: cross_type_cross_type_enum
        doc: 'crossType'
      - id: trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'tradeType'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'execInst'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'priceType'
      - id: bypass_mqr
        type: u1
        enum: bypass_mqr
        doc: 'bypassMQR'
      - id: hedge_only
        type: u1
        enum: hedge_only
        doc: 'hedgeOnly'
      - id: benchmark_price
        type: s8
        doc: 'benchmarkPrice'
      - id: bench_mark_price_type
        type: u1
        enum: bench_mark_price_type
        doc: 'benchMarkPriceType'
      - id: time_in_force_time_in_force_enum
        type: u1
        enum: time_in_force_time_in_force_enum
        doc: 'timeInForce'
      - id: transact_details
        type: str
        size: 100
        encoding: ASCII
        doc: 'transactDetails'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: new_order_cross_request_message_no_sides_groups
        type: new_order_cross_request_message_no_sides_groups
        doc: 'noSides Block'
      - id: new_order_cross_request_message_no_legs_groups
        type: new_order_cross_request_message_no_legs_groups
        doc: 'noLegs Block'
  new_order_cross_request_message_no_sides_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: new_order_cross_request_message_no_sides_group
        type: new_order_cross_request_message_no_sides_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noSides'
  new_order_cross_request_message_no_sides_group:
    seq:
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: give_up_clearing_firm
        type: s4
        doc: 'giveUpClearingFirm'
      - id: clearing_firm_int_32
        type: s4
        doc: 'clearingFirm'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: self_match_prevention_id
        type: s8
        doc: 'selfMatchPreventionID'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'selfMatchPreventionInstruction'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'manualOrderIndicator'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'custOrderHandlingInst'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'positionEffect'
      - id: alloc_handl_inst
        type: u1
        enum: alloc_handl_inst
        doc: 'allocHandlInst'
      - id: clearing_account_string_14
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: customer_account_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'customerAccountRefID'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: allocation_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'allocationAccount'
      - id: on_behalf_of_comp_id
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfCompId'
      - id: on_behalf_of_sub_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
      - id: on_behalf_of_location_i_d_string_41
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfLocationID'
  new_order_cross_request_message_no_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: new_order_cross_request_message_no_legs_group
        type: new_order_cross_request_message_no_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noLegs'
  new_order_cross_request_message_no_legs_group:
    seq:
      - id: leg_symbol_int_32_null
        type: s4
        doc: 'legSymbol'
      - id: leg_security_id_source
        type: s1
        doc: 'legSecurityIDSource'
      - id: leg_opt_attribute
        type: s4
        doc: 'legOptAttribute'
      - id: leg_qty
        type: s8
        doc: 'legQty'
      - id: leg_price
        type: s8
        doc: 'Required if legSecurityType is FUT'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'legSecurityType'
      - id: leg_memo_field
        type: str
        size: 12
        encoding: ASCII
        doc: 'legMemoField'
      - id: leg_security_id
        type: str
        size: 75
        encoding: ASCII
        doc: 'legSecurityID'
  order_mass_cancel_request_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: ord_type_order_type_enum_null
        type: u1
        enum: ord_type_order_type_enum_null
        doc: 'ordType'
      - id: side_side_enum_null
        type: u1
        enum: side_side_enum_null
        doc: 'side'
      - id: symbol_int_32_null
        type: s4
        doc: 'symbol'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: market_type_i_d_int_32_null
        type: s4
        doc: 'marketTypeID'
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'massCancelRequestType'
      - id: time_in_force_time_in_force_enum_null
        type: u1
        enum: time_in_force_time_in_force_enum_null
        doc: 'timeInForce'
      - id: on_behalf_of_sub_i_d_string_41_null
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
  mass_quote_request_message:
    seq:
      - id: quote_id
        type: s8
        doc: 'quoteID'
      - id: risk_protection_reset
        type: u1
        enum: risk_protection_reset
        doc: 'riskProtectionReset'
      - id: self_match_prevention_id
        type: s8
        doc: 'selfMatchPreventionID'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'selfMatchPreventionInstruction'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: mass_quote_request_message_no_quote_sets_groups
        type: mass_quote_request_message_no_quote_sets_groups
        doc: 'noQuoteSets Block'
  mass_quote_request_message_no_quote_sets_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: mass_quote_request_message_no_quote_sets_group
        type: mass_quote_request_message_no_quote_sets_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noQuoteSets'
  mass_quote_request_message_no_quote_sets_group:
    seq:
      - id: quote_set_id
        type: s4
        doc: 'quoteSetID'
      - id: underlying_symbol_int_32
        type: s4
        doc: 'underlyingSymbol'
      - id: quote_entry_id
        type: s4
        doc: 'quoteEntryID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: bid_px
        type: s8
        doc: 'bidPx'
      - id: offer_px
        type: s8
        doc: 'offerPx'
      - id: bid_sz
        type: s8
        doc: 'bidSz'
      - id: offer_sz
        type: s8
        doc: 'offerSz'
  quote_cancel_request_message:
    seq:
      - id: quote_id
        type: s8
        doc: 'quoteID'
      - id: quote_cancel_type
        type: u1
        enum: quote_cancel_type
        doc: 'quoteCancelType'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: quote_cancel_request_message_no_quote_entries_groups
        type: quote_cancel_request_message_no_quote_entries_groups
        doc: 'noQuoteEntries Block'
  quote_cancel_request_message_no_quote_entries_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: quote_cancel_request_message_no_quote_entries_group
        type: quote_cancel_request_message_no_quote_entries_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noQuoteEntries'
  quote_cancel_request_message_no_quote_entries_group:
    seq:
      - id: underlying_symbol_int_32_null
        type: s4
        doc: 'underlyingSymbol'
      - id: underlying_security_id
        type: s4
        doc: 'underlyingSecurityID'
      - id: underlying_product
        type: s4
        doc: 'underlyingProduct'
  security_definition_request_create_strategy_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_request_type
        type: u1
        enum: security_request_type
        doc: 'securityRequestType'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: security_sub_type_int_16_null
        type: s2
        doc: 'securitySubType'
      - id: product_i_d_int_32_null
        type: s4
        doc: 'productID'
      - id: start_date
        type: u2
        doc: 'startDate'
      - id: end_date
        type: u2
        doc: 'endDate'
      - id: security_type_security_type_enum
        type: u1
        enum: security_type_security_type_enum
        doc: 'securityType'
      - id: security_definition_request_create_strategy_message_no_legs_groups
        type: security_definition_request_create_strategy_message_no_legs_groups
        doc: 'noLegs Block'
  security_definition_request_create_strategy_message_no_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: security_definition_request_create_strategy_message_no_legs_group
        type: security_definition_request_create_strategy_message_no_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noLegs'
  security_definition_request_create_strategy_message_no_legs_group:
    seq:
      - id: leg_symbol_int_32
        type: s4
        doc: 'legSymbol'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'legSecurityType'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'legSide'
      - id: leg_ratio_qty_denominator_int_16_null
        type: s2
        doc: 'Required if legSecurityType is OPT or FUT'
      - id: leg_ratio_qty_numerator_int_16_null
        type: s2
        doc: 'Required if legSecurityType is OPT or FUT'
      - id: leg_price
        type: s8
        doc: 'Required if legSecurityType is FUT'
      - id: leg_option_delta
        type: s4
        doc: 'Required if legSecurityType is FUT or CS'
  security_definition_request_create_flex_message:
    seq:
      - id: security_req_id
        type: s4
        doc: 'securityReqID'
      - id: security_request_type
        type: u1
        enum: security_request_type
        doc: 'securityRequestType'
      - id: market_type_i_d_int_32
        type: s4
        doc: 'marketTypeID'
      - id: security_type_security_type_enum
        type: u1
        enum: security_type_security_type_enum
        doc: 'securityType'
      - id: maturity_date
        type: u2
        doc: 'maturityDate'
      - id: product_i_d_int_32_null
        type: s4
        doc: 'productID'
      - id: symbol_int_32_null
        type: s4
        doc: 'symbol'
      - id: strike_price
        type: s8
        doc: 'strikePrice'
  execution_report_new_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_order_exec_id
        type: exec_i_d_order_exec_id
        doc: 'ExecutionReport_NewMessage'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: leaves_qty
        type: s8
        doc: 'leavesQty'
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: me_acceptance_time_utc_timestamp
        type: u8
        doc: 'meAcceptanceTime'
      - id: time_priority
        type: u8
        doc: 'timePriority'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'orderStatus'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
  exec_i_d_order_exec_id:
    seq:
      - id: system_id
        type: s8
        doc: 'systemID'
      - id: system_sequence_id
        type: s4
        doc: 'systemSequenceID'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
  orig_order_id:
    seq:
      - id: original_system_id
        type: s8
        doc: 'originalSystemID'
      - id: original_creation_timestamp
        type: u8
        doc: 'originalCreationTimestamp'
  execution_report_modify_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_order_exec_id
        type: exec_i_d_order_exec_id
        doc: 'ExecutionReport_NewMessage'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: orig_cl_ord_i_d_int_64_null
        type: s8
        doc: 'origClOrdID'
      - id: leaves_qty
        type: s8
        doc: 'leavesQty'
      - id: cum_qty
        type: s8
        doc: 'cumQty'
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: me_acceptance_time_utc_timestamp
        type: u8
        doc: 'meAcceptanceTime'
      - id: time_priority
        type: u8
        doc: 'timePriority'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'execType'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'orderStatus'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'orderState'
      - id: exec_restatement_reason
        type: u1
        enum: exec_restatement_reason
        doc: 'execRestatementReason'
      - id: order_modification_flags
        type: order_modification_flags
        doc: 'OrderFlags bit set'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
  order_modification_flags:
    meta:
      bit-endian: le
    seq:
      - id: stop_limit_price_changed
        type: b1
        doc: 'stopLimitPriceChanged'
      - id: stop_elected
        type: b1
        doc: 'stopElected'
      - id: order_flags_reserved_2
        type: b1
        doc: 'reserved2'
      - id: order_flags_reserved_3
        type: b1
        doc: 'reserved3'
      - id: order_flags_reserved_4
        type: b1
        doc: 'reserved4'
      - id: order_flags_reserved_5
        type: b1
        doc: 'reserved5'
      - id: order_flags_reserved_6
        type: b1
        doc: 'reserved6'
      - id: order_flags_reserved_7
        type: b1
        doc: 'reserved7'
  execution_report_cancel_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_order_exec_id
        type: exec_i_d_order_exec_id
        doc: 'ExecutionReport_NewMessage'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: orig_cl_ord_i_d_int_64_null
        type: s8
        doc: 'origClOrdID'
      - id: me_acceptance_time_utc_timestamp
        type: u8
        doc: 'meAcceptanceTime'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'cancelReason'
      - id: cross_i_d_int_64_null
        type: s8
        doc: 'crossID'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  execution_report_reject_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_order_exec_id
        type: exec_i_d_order_exec_id
        doc: 'ExecutionReport_NewMessage'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum_null
        type: u1
        enum: ord_type_order_type_enum_null
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: orig_cl_ord_i_d_int_64_null
        type: s8
        doc: 'origClOrdID'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'orderStatus'
      - id: reject_response_to
        type: u1
        enum: reject_response_to
        doc: 'rejectResponseTo'
      - id: reject_reason
        type: u1
        enum: reject_reason
        doc: 'rejectReason'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  execution_report_snapshot_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_order_exec_id
        type: exec_i_d_order_exec_id
        doc: 'ExecutionReport_NewMessage'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: max_show
        type: s8
        doc: 'maxShow'
      - id: leaves_qty
        type: s8
        doc: 'leavesQty'
      - id: cum_qty
        type: s8
        doc: 'cumQty'
      - id: price_decimal_9_null
        type: s8
        doc: 'price'
      - id: stop_px
        type: s8
        doc: 'stopPx'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: time_priority
        type: u8
        doc: 'timePriority'
      - id: time_in_force_time_in_force_enum
        type: u1
        enum: time_in_force_time_in_force_enum
        doc: 'timeInForce'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'orderStatus'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'orderState'
      - id: give_up_clearing_firm
        type: s4
        doc: 'giveUpClearingFirm'
      - id: clearing_firm_int_32_null
        type: s4
        doc: 'clearingFirm'
      - id: direct_electronic_access
        type: u1
        enum: direct_electronic_access
        doc: 'directElectronicAccess'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        doc: 'liquidityProvision'
      - id: commodity_deriv_indicator
        type: u1
        enum: commodity_deriv_indicator
        doc: 'commodityDerivIndicator'
      - id: investment_decision
        type: s8
        doc: 'investmentDecision'
      - id: execution_decision
        type: s8
        doc: 'executionDecision'
      - id: client_id_code
        type: s8
        doc: 'clientIDCode'
      - id: mifid_id
        type: s8
        doc: 'mifidID'
      - id: self_match_prevention_id
        type: s8
        doc: 'selfMatchPreventionID'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'selfMatchPreventionInstruction'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'manualOrderIndicator'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'execInst'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'custOrderHandlingInst'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'positionEffect'
      - id: alloc_handl_inst
        type: u1
        enum: alloc_handl_inst
        doc: 'allocHandlInst'
      - id: clearing_account_string_14_null
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: customer_account_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'customerAccountRefID'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: allocation_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'allocationAccount'
      - id: on_behalf_of_comp_id
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfCompId'
      - id: on_behalf_of_sub_i_d_string_41_null
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfSubID'
      - id: on_behalf_of_location_i_d_string_41_null
        type: str
        size: 41
        encoding: ASCII
        doc: 'onBehalfOfLocationID'
  execution_report_trade_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: exec_i_d_int_64
        type: s8
        doc: 'execID'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: ord_type_order_type_enum
        type: u1
        enum: ord_type_order_type_enum
        doc: 'ordType'
      - id: side_side_enum
        type: u1
        enum: side_side_enum
        doc: 'side'
      - id: order_id
        type: s8
        doc: 'orderID'
      - id: orig_order_id
        type: orig_order_id
        doc: 'ExecutionReport_NewMessage'
      - id: leaves_qty
        type: s8
        doc: 'leavesQty'
      - id: cum_qty
        type: s8
        doc: 'cumQty'
      - id: last_px
        type: s8
        doc: 'lastPx'
      - id: last_shares
        type: s8
        doc: 'lastShares'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: num_of_lots
        type: s8
        doc: 'numOfLots'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'execType'
      - id: trade_flags
        type: trade_flags
        doc: 'TradeFlags bit set'
      - id: clearing_firm_int_32_null
        type: s4
        doc: 'clearingFirm'
      - id: clearing_account_string_14_null
        type: str
        size: 14
        encoding: ASCII
        doc: 'clearingAccount'
      - id: memo
        type: str
        size: 30
        encoding: ASCII
        doc: 'memo'
      - id: exec_ref_id
        type: s8
        doc: 'execRefID'
      - id: no_leg_executions
        type: s2
        doc: 'noLegExecutions'
      - id: secondary_exec_id
        type: s8
        doc: 'secondaryExecID'
      - id: link_exec_id
        type: s8
        doc: 'linkExecID'
      - id: last_par_px
        type: s8
        doc: 'lastParPx'
      - id: delivery_start_date
        type: u8
        doc: 'deliveryStartDate'
      - id: delivery_end_date
        type: u8
        doc: 'deliveryEndDate'
      - id: cross_i_d_int_64_null
        type: s8
        doc: 'crossID'
      - id: cross_type_cross_type_enum_null
        type: u1
        enum: cross_type_cross_type_enum_null
        doc: 'crossType'
      - id: waiver_indicator
        type: u1
        enum: waiver_indicator
        doc: 'waiverIndicator'
      - id: trade_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'tradeType'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: liquidity_indicator
        type: b1
        doc: 'liquidityIndicator'
      - id: deal_adjust_indicator
        type: b1
        doc: 'dealAdjustIndicator'
      - id: trade_flags_reserved_2
        type: b1
        doc: 'reserved2'
      - id: trade_flags_reserved_3
        type: b1
        doc: 'reserved3'
      - id: trade_flags_reserved_4
        type: b1
        doc: 'reserved4'
      - id: trade_flags_reserved_5
        type: b1
        doc: 'reserved5'
      - id: trade_flags_reserved_6
        type: b1
        doc: 'reserved6'
      - id: trade_flags_reserved_7
        type: b1
        doc: 'reserved7'
  quote_report_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: side_side_enum_null
        type: u1
        enum: side_side_enum_null
        doc: 'side'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: rfq_req_id
        type: s8
        doc: 'rfqReqID'
      - id: rfq_system_id
        type: s8
        doc: 'rfqSystemID'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: order_qty_decimal_9_null
        type: s8
        doc: 'orderQty'
      - id: quote_ack_status
        type: u2
        enum: quote_ack_status
        doc: 'quoteAckStatus'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'quoteRejectReason'
  new_order_cross_report_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: cross_i_d_int_64
        type: s8
        doc: 'crossID'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: rfc_status
        type: u1
        enum: rfc_status
        doc: 'rfcStatus'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  order_mass_cancel_report_message:
    seq:
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: symbol_int_32_null
        type: s4
        doc: 'symbol'
      - id: cl_ord_id
        type: s8
        doc: 'clOrdID'
      - id: transact_time_utc_timestamp
        type: u8
        doc: 'transactTime'
      - id: market_type_i_d_int_32_null
        type: s4
        doc: 'marketTypeID'
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'massCancelRequestType'
      - id: mass_cancel_response
        type: u1
        enum: mass_cancel_response
        doc: 'massCancelResponse'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'massCancelRejectReason'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  mass_quote_report_message:
    seq:
      - id: quote_id
        type: s8
        doc: 'quoteID'
      - id: originator_user_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'originatorUserID'
      - id: risk_protection_reset
        type: u1
        enum: risk_protection_reset
        doc: 'riskProtectionReset'
      - id: quote_ack_status
        type: u2
        enum: quote_ack_status
        doc: 'quoteAckStatus'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'quoteRejectReason'
      - id: transact_time_utc_timestamp_null
        type: u8
        doc: 'transactTime'
      - id: me_acceptance_time_utc_timestamp_null
        type: u8
        doc: 'meAcceptanceTime'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
      - id: mass_quote_report_message_no_quote_sets_groups
        type: mass_quote_report_message_no_quote_sets_groups
        doc: 'noQuoteSets Block'
  mass_quote_report_message_no_quote_sets_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: mass_quote_report_message_no_quote_sets_group
        type: mass_quote_report_message_no_quote_sets_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noQuoteSets'
  mass_quote_report_message_no_quote_sets_group:
    seq:
      - id: quote_set_id
        type: s4
        doc: 'quoteSetID'
      - id: underlying_symbol_int_32
        type: s4
        doc: 'underlyingSymbol'
      - id: quote_entry_id
        type: s4
        doc: 'quoteEntryID'
      - id: symbol_int_32
        type: s4
        doc: 'symbol'
      - id: quote_entry_reject_reason
        type: u1
        enum: quote_entry_reject_reason
        doc: 'quoteEntryRejectReason'
      - id: quote_entry_exchange_code
        type: s4
        doc: 'quoteEntryExchangeCode'
      - id: quote_entry_reject_reason_text
        type: str
        size: 100
        encoding: ASCII
        doc: 'quoteEntryRejectReasonText'
  resend_request_message:
    seq:
      - id: begin_seq_no
        type: u4
        doc: 'beginSeqNo'
      - id: end_seq_no
        type: u4
        doc: 'endSeqNo'
  resend_report_message:
    seq:
      - id: begin_seq_no
        type: u4
        doc: 'beginSeqNo'
      - id: end_seq_no
        type: u4
        doc: 'endSeqNo'
      - id: status
        type: u1
        enum: status
        doc: 'status'
      - id: exchange_code
        type: s4
        doc: 'exchangeCode'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'text'
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'newSeqNo'
      - id: gap_fill_flag
        type: u1
        enum: gap_fill_flag
        doc: 'gapFillFlag'
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
  template_id:
    0:
      id: 'simple_open_framing_header_message'
      doc: 'SimpleOpenFramingHeaderMessage'
    1:
      id: 'logon_request_message'
      doc: 'LogonRequestMessage'
    101:
      id: 'logon_report_message'
      doc: 'LogonReportMessage'
    13:
      id: 'logout_request_message'
      doc: 'LogoutRequestMessage'
    113:
      id: 'logout_report_message'
      doc: 'LogoutReportMessage'
    51:
      id: 'heart_beat_message'
      doc: 'HeartBeatMessage'
    114:
      id: 'error_message'
      doc: 'ErrorMessage'
    116:
      id: 'news_message'
      doc: 'NewsMessage'
    112:
      id: 'security_definition_report_strategy_message'
      doc: 'SecurityDefinitionReport_StrategyMessage'
    115:
      id: 'security_definition_report_message'
      doc: 'SecurityDefinitionReportMessage'
    155:
      id: 'security_definition_reject_message'
      doc: 'SecurityDefinitionRejectMessage'
    15:
      id: 'security_definition_request_message'
      doc: 'SecurityDefinitionRequestMessage'
    154:
      id: 'security_definition_report_product_message'
      doc: 'SecurityDefinitionReport_ProductMessage'
    2001:
      id: 'ip_request_message'
      doc: 'IPRequestMessage'
    2002:
      id: 'ip_report_message'
      doc: 'IPReportMessage'
    2:
      id: 'trader_logon_request_message'
      doc: 'TraderLogonRequestMessage'
    102:
      id: 'trader_logon_report_message'
      doc: 'TraderLogonReportMessage'
    3:
      id: 'trader_logout_request_message'
      doc: 'TraderLogoutRequestMessage'
    103:
      id: 'trader_logout_report_message'
      doc: 'TraderLogoutReportMessage'
    4:
      id: 'new_order_request_message'
      doc: 'NewOrderRequestMessage'
    5:
      id: 'cancel_replace_request_message'
      doc: 'CancelReplaceRequestMessage'
    6:
      id: 'cancel_request_message'
      doc: 'CancelRequestMessage'
    7:
      id: 'quote_request_message'
      doc: 'QuoteRequestMessage'
    8:
      id: 'new_order_cross_request_message'
      doc: 'NewOrderCrossRequestMessage'
    9:
      id: 'order_mass_cancel_request_message'
      doc: 'OrderMassCancelRequestMessage'
    10:
      id: 'mass_quote_request_message'
      doc: 'MassQuoteRequestMessage'
    11:
      id: 'quote_cancel_request_message'
      doc: 'QuoteCancelRequestMessage'
    12:
      id: 'security_definition_request_create_strategy_message'
      doc: 'SecurityDefinitionRequest_CreateStrategyMessage'
    14:
      id: 'security_definition_request_create_flex_message'
      doc: 'SecurityDefinitionRequest_CreateFlexMessage'
    104:
      id: 'execution_report_new_message'
      doc: 'ExecutionReport_NewMessage'
    105:
      id: 'execution_report_modify_message'
      doc: 'ExecutionReport_ModifyMessage'
    106:
      id: 'execution_report_cancel_message'
      doc: 'ExecutionReport_CancelMessage'
    151:
      id: 'execution_report_reject_message'
      doc: 'ExecutionReport_RejectMessage'
    152:
      id: 'execution_report_snapshot_message'
      doc: 'ExecutionReport_SnapshotMessage'
    153:
      id: 'execution_report_trade_message'
      doc: 'ExecutionReport_TradeMessage'
    107:
      id: 'quote_report_message'
      doc: 'QuoteReportMessage'
    108:
      id: 'new_order_cross_report_message'
      doc: 'NewOrderCrossReportMessage'
    109:
      id: 'order_mass_cancel_report_message'
      doc: 'OrderMassCancelReportMessage'
    110:
      id: 'mass_quote_report_message'
      doc: 'MassQuoteReportMessage'
    16:
      id: 'resend_request_message'
      doc: 'ResendRequestMessage'
    117:
      id: 'resend_report_message'
      doc: 'ResendReportMessage'
    111:
      id: 'sequence_reset_message'
      doc: 'SequenceResetMessage'
  severity_level:
    1:
      id: 'info'
      doc: 'SeverityLevelEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'warning'
      doc: 'SeverityLevelEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'error'
      doc: 'SeverityLevelEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'fatal'
      doc: 'SeverityLevelEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  security_response_type:
    1:
      id: 'accepted_security_as_defined'
      doc: 'SecurityResponseTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'accepted_security_per_request'
      doc: 'SecurityResponseTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    5:
      id: 'rejected_security_per_request'
      doc: 'SecurityResponseTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'security_already_defined'
      doc: 'SecurityResponseTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  security_trading_status:
    2:
      id: 'trading_halt_suspended'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'no_open_no_resume_pre_close'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    17:
      id: 'ready_to_trade_open'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    18:
      id: 'not_available_for_trading_close'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    19:
      id: 'not_traded'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    20:
      id: 'unknown_or_invalid_expired'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    21:
      id: 'pre_open'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    100:
      id: 'trading_as_strategy_leg_only_open'
      doc: 'SecurityTradingStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  exchange_silo:
    0:
      id: 'ice'
      doc: 'ExchangeSiloEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'endex'
      doc: 'ExchangeSiloEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'liffe'
      doc: 'ExchangeSiloEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  leg_deals_suppressed:
    0:
      id: 'false_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  block_only:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  flex_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  gt_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mifid_regulated_market_boolean_enum:
    0:
      id: 'false_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  override_block_min:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  test_market_indicator_boolean_enum:
    0:
      id: 'false_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  block_details_block_type:
    0:
      id: 'regular'
      doc: 'BlockTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'pnc'
      doc: 'BlockTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'dp'
      doc: 'BlockTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'lis'
      doc: 'BlockTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  leg_security_type:
    1:
      id: 'fut'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'opt'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'common_stock'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'mleg'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  leg_side:
    1:
      id: 'buy'
      doc: 'SideEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  put_or_call:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  settl_method:
    0x43:
      id: 'cash_financial'
      doc: 'SettlMethodEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'physical'
      doc: 'SettlMethodEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  strike_exercise_style:
    0:
      id: 'european'
      doc: 'StrikeExerciseStyleEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'american'
      doc: 'StrikeExerciseStyleEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'asian'
      doc: 'StrikeExerciseStyleEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  clearable:
    0:
      id: 'false_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  hedge_only:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  is_dividend_adjusted:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  aon_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mifid_regulated_market_boolean_enum_null:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  flex_strike_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  test_market_indicator_boolean_enum_null:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  market_transparency_type:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  non_commoditized_market:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  security_request_type:
    1:
      id: 'create_strategy'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'request_listof_futures'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    100:
      id: 'request_listof_options'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    101:
      id: 'request_listof_strategies'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    102:
      id: 'create_flex_option'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    103:
      id: 'create_flex_expiry'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    104:
      id: 'request_list_of_products'
      doc: 'SecurityRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  security_type_security_type_enum_null:
    1:
      id: 'fut'
      doc: 'SecurityTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'opt'
      doc: 'SecurityTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'common_stock'
      doc: 'SecurityTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'mleg'
      doc: 'SecurityTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  stops_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  options_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  uds_options_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  uds_futures_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mass_quotes_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  rfq_futures_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  rfq_options_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  crossing_order_futures_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  crossing_order_options_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  self_block_allowed:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  success:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  direct_electronic_access:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  trading_capacity:
    0:
      id: 'deal'
      doc: 'TradingCapacityEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'mtch'
      doc: 'TradingCapacityEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'aotc'
      doc: 'TradingCapacityEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  liquidity_provision:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  commodity_deriv_indicator:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  time_in_force_time_in_force_enum:
    0:
      id: 'day'
      doc: 'TimeInForceEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'gtc'
      doc: 'TimeInForceEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fak'
      doc: 'TimeInForceEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'fok'
      doc: 'TimeInForceEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'gtd'
      doc: 'TimeInForceEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  side_side_enum:
    1:
      id: 'buy'
      doc: 'SideEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  ord_type_order_type_enum:
    1:
      id: 'market'
      doc: 'OrderTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'limit'
      doc: 'OrderTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'stop'
      doc: 'OrderTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'stop_limit'
      doc: 'OrderTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  manual_order_indicator:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  self_match_prevention_instruction:
    0x52:
      id: 'cancel_resting_order'
      doc: 'SelfMatchPreventionInstructionEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'cancel_taking_order'
      doc: 'SelfMatchPreventionInstructionEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'cancel_both_orders'
      doc: 'SelfMatchPreventionInstructionEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  exec_inst:
    0x47:
      id: 'aon'
      doc: 'ExecInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'pnc'
      doc: 'ExecInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'dp'
      doc: 'ExecInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  cust_order_handling_inst:
    0x43:
      id: 'c'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'd'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'g'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'h'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'w'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'y'
      doc: 'CustOrderHandlingInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  position_effect:
    0x4f:
      id: 'open'
      doc: 'PositionEffectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'close'
      doc: 'PositionEffectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  alloc_handl_inst:
    0x41:
      id: 'apt'
      doc: 'AllocHandlInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'g'
      doc: 'AllocHandlInstEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  price_type:
    2:
      id: 'per_contract'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'fixed_cabinet_trade_price'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    100:
      id: 'fixed_rate'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    101:
      id: 'npv'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    102:
      id: 'rate_differential'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    103:
      id: 'npv_differential'
      doc: 'PriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  side_side_enum_null:
    1:
      id: 'buy'
      doc: 'SideEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  cross_type_cross_type_enum:
    0x31:
      id: 'aon'
      doc: 'CrossTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'ioc'
      doc: 'CrossTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  bypass_mqr:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  bench_mark_price_type:
    3:
      id: 'fixed_amount'
      doc: 'BenchmarkPriceTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  ord_type_order_type_enum_null:
    1:
      id: 'market'
      doc: 'OrderTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'limit'
      doc: 'OrderTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'stop'
      doc: 'OrderTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'stop_limit'
      doc: 'OrderTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mass_cancel_request_type:
    6:
      id: 'cancel_for_trading_session'
      doc: 'MassCancelRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'cancel_all_for_trader'
      doc: 'MassCancelRequestTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  time_in_force_time_in_force_enum_null:
    0:
      id: 'day'
      doc: 'TimeInForceEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'gtc'
      doc: 'TimeInForceEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fak'
      doc: 'TimeInForceEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'fok'
      doc: 'TimeInForceEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'gtd'
      doc: 'TimeInForceEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  risk_protection_reset:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  quote_cancel_type:
    3:
      id: 'cancel_by_underlying_market'
      doc: 'QuoteCancelTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancel_all'
      doc: 'QuoteCancelTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cancel_by_product_id'
      doc: 'QuoteCancelTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  security_type_security_type_enum:
    1:
      id: 'fut'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'opt'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'common_stock'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'mleg'
      doc: 'SecurityTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  order_status:
    0:
      id: 'new_field'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'partial_fill'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'fill'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'canceled'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    5:
      id: 'replace'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    8:
      id: 'rejected'
      doc: 'OrderStatusEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'partial_fill'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'fill'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'cancelled'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'replaced'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'rejected'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'restated'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'trade_correct'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'trade_cancel'
      doc: 'ExecTypeEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  order_state:
    0:
      id: 'active'
      doc: 'OrderStateEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'inactive'
      doc: 'OrderStateEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'withdrawn'
      doc: 'OrderStateEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'consummated'
      doc: 'OrderStateEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'elected'
      doc: 'OrderStateEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  exec_restatement_reason:
    3:
      id: 'repriced'
      doc: 'ExecRestatementReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'ExecRestatementReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  cancel_reason:
    0:
      id: 'canceled_by_user'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    7:
      id: 'canceled_by_system'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'canceled_for_reasonability_limits'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    11:
      id: 'canceled_at_market_close'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    13:
      id: 'canceled_for_ipl'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    27:
      id: 'canceled_for_ioc'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    28:
      id: 'canceled_for_fok'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    31:
      id: 'canceled_for_market'
      doc: 'CancelReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  reject_response_to:
    1:
      id: 'cancel'
      doc: 'RejectResponseToEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel_replace'
      doc: 'RejectResponseToEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'new_order'
      doc: 'RejectResponseToEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  reject_reason:
    0:
      id: 'too_late_to_cancel'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'unknown_symbol'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'exchange_closed'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_exceeds_limit'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'unable_to_process_request'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    5:
      id: 'unknown_order'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_order'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    7:
      id: 'missing_permissions'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    9:
      id: 'user_defined'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'cancel_or_replace_pending'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    11:
      id: 'unsupported'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    12:
      id: 'risk_protection_active'
      doc: 'RejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  cross_type_cross_type_enum_null:
    0x31:
      id: 'aon'
      doc: 'CrossTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'ioc'
      doc: 'CrossTypeEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  waiver_indicator:
    1:
      id: 'lrgs'
      doc: 'WaiverIndicatorEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'size'
      doc: 'WaiverIndicatorEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'ilqd'
      doc: 'WaiverIndicatorEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  quote_ack_status:
    0:
      id: 'accepted'
      doc: 'QuoteAckStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancelled_all'
      doc: 'QuoteAckStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    5:
      id: 'rejected'
      doc: 'QuoteAckStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    200:
      id: 'partially_cancelled'
      doc: 'QuoteAckStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    300:
      id: 'unreasonable_quotes'
      doc: 'QuoteAckStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  quote_reject_reason:
    0:
      id: 'accepted'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    100:
      id: 'validation_failure'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    101:
      id: 'invalid_user_id'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    102:
      id: 'risk_protection_active'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    104:
      id: 'no_clearing_account_for_trader'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    105:
      id: 'no_mass_quote_sets'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    106:
      id: 'first_set_mass_quote_is_empty'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    107:
      id: 'invalid_clearing_account_status'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    108:
      id: 'invalid_clearing_limits'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    109:
      id: 'invalid_market_id'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    110:
      id: 'exceeds_allowed_mass_quote_sets'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    111:
      id: 'exceeds_allowed_mass_quotes'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    112:
      id: 'invalid_mass_quote_id'
      doc: 'QuoteRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  rfc_status:
    0:
      id: 'none'
      doc: 'RFCStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'success'
      doc: 'RFCStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'partial_success_bid_failure'
      doc: 'RFCStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    3:
      id: 'partial_success_offer_failure'
      doc: 'RFCStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    4:
      id: 'failure'
      doc: 'RFCStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mass_cancel_response:
    0:
      id: 'rejected'
      doc: 'MassCancelResponseEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'cancel_for_trading_session'
      doc: 'MassCancelResponseEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    10:
      id: 'cancel_all_for_trader'
      doc: 'MassCancelResponseEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  mass_cancel_reject_reason:
    0:
      id: 'unsupported'
      doc: 'MassCancelRejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_trading_session'
      doc: 'MassCancelRejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_market'
      doc: 'MassCancelRejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'MassCancelRejectEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  quote_entry_reject_reason:
    99:
      id: 'other'
      doc: 'QuoteEntryRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    102:
      id: 'risk_protection_active'
      doc: 'QuoteEntryRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    113:
      id: 'risk_protection_active_for_sell_side'
      doc: 'QuoteEntryRejectReasonEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  status:
    0:
      id: 'success'
      doc: 'RequestStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'partial_success'
      doc: 'RequestStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    2:
      id: 'failure'
      doc: 'RequestStatusEnum Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
  gap_fill_flag:
    0:
      id: 'false_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanEnumNULL Scaled.Binary.Specification.Load.Sbe.Ice.Xml.Xml.typesEnumValidValue'

