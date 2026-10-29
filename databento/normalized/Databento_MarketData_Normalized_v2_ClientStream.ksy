# ---------------------------------------------------------------------
# Kaitai struct definition for: Databento Normalized Dbn v2
#
# Protocol:
#   Organization: Databento
#   Protocol: Normalized
#   Encoding: Databento Binary Encoding
#   Version: 2
#   Date: 10/4/2026
#   Specification: Unknown
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
  id: databento_marketdata_normalized_dbn_v2_clientstream
  title: Databento Normalized Dbn v2
  license: GPL-3.0
  endian: le

doc: 'Databento Databento Market Data Normalized Dbn v2'
doc-ref:
  - https://databento.com/docs/standards-and-conventions/databento-binary-encoding
  - https://github.com/databento/dbn
  - https://databento.com/docs/api-reference-live/basics/protocol
  - https://github.com/databento/databento-rs

seq:
  - id: control_message
    type: control_message_struct
    repeat: eos
    doc: 'A control message: key=value fields separated by |, ending on a newline'

types:
  control_message_struct:
    seq:
      - id: control_fields
        type: str
        terminator: 10
        encoding: ASCII
        doc: 'ASCII key=value pairs separated by the | character, terminated by a newline character'

enums:
  schema:
    0: 'mbo'
    1: 'mbp1'
    2: 'mbp10'
    3: 'tbbo'
    4: 'trades'
    5: 'ohlcv1_s'
    6: 'ohlcv1_m'
    7: 'ohlcv1_h'
    8: 'ohlcv1_d'
    9: 'definition'
    10: 'statistics'
    11: 'status'
    12: 'imbalance'
    13: 'ohlcv_eod'
    14: 'cmbp1'
    15: 'cbbo1_s'
    16: 'cbbo1_m'
    17: 'tcbbo'
    18: 'bbo1_s'
    19: 'bbo1_m'
  stype_in:
    0: 'instrument_id'
    1: 'raw_symbol'
    2: 'smart'
    3: 'continuous'
    4: 'parent'
    5: 'nasdaq_symbol'
    6: 'cms_symbol'
    7: 'isin'
    8: 'us_code'
    9: 'bbg_comp_id'
    10: 'bbg_comp_ticker'
    11: 'figi'
    12: 'figi_ticker'
    13: 'listing_id'
    14: 'issuer_id'
    15: 'security_id'
  stype_out:
    0: 'instrument_id'
    1: 'raw_symbol'
    2: 'smart'
    3: 'continuous'
    4: 'parent'
    5: 'nasdaq_symbol'
    6: 'cms_symbol'
    7: 'isin'
    8: 'us_code'
    9: 'bbg_comp_id'
    10: 'bbg_comp_ticker'
    11: 'figi'
    12: 'figi_ticker'
    13: 'listing_id'
    14: 'issuer_id'
    15: 'security_id'
  ts_out:
    0: 'no_field'
    1: 'yes_field'
  rtype:
    0: 'market_by_price_0'
    1: 'market_by_price_1'
    10: 'market_by_price_10'
    17: 'ohlcv_deprecated'
    18: 'status'
    19: 'instrument_definition'
    20: 'imbalance'
    21: 'error'
    22: 'symbol_mapping'
    23: 'system'
    24: 'statistics'
    32: 'ohlcv_1_second'
    33: 'ohlcv_1_minute'
    34: 'ohlcv_1_hour'
    35: 'ohlcv_1_day'
    36: 'ohlcv_end_of_day'
    160: 'market_by_order'
    177: 'consolidated_market_by_price_1'
    192: 'consolidated_bbo_1_second'
    193: 'consolidated_bbo_1_minute'
    194: 'trade_with_consolidated_bbo'
    195: 'bbo_1_second'
    196: 'bbo_1_minute'
  action:
    0x41:
      id: 'add'
      doc: 'A new order was added to the book'
    0x43:
      id: 'cancel'
      doc: 'An order was fully or partially cancelled'
    0x46:
      id: 'fill'
      doc: 'An existing order was filled; does not affect the book'
    0x4d:
      id: 'modify'
      doc: 'An existing order was modified: price and/or size'
    0x4e:
      id: 'none'
      doc: 'Has no effect on the book, but may carry flags or other information'
    0x52:
      id: 'clear'
      doc: 'Reset the book; clear all orders for an instrument'
    0x54:
      id: 'trade'
      doc: 'An aggressing order traded; does not affect the book'
  side:
    0x41:
      id: 'ask'
      doc: 'A sell order or sell aggressor in a trade'
    0x42:
      id: 'bid'
      doc: 'A buy order or a buy aggressor in a trade'
    0x4e:
      id: 'none'
      doc: 'No side specified by the original source'
  status_action:
    0: 'none'
    1: 'pre_open'
    2: 'pre_cross'
    3: 'quoting'
    4: 'cross'
    5: 'rotation'
    6: 'new_price_indication'
    7: 'trading'
    8: 'halt'
    9: 'pause'
    10: 'suspend'
    11: 'pre_close'
    12: 'close'
    13: 'post_close'
    14: 'ssr_change'
    15: 'not_available_for_trading'
  status_reason:
    0: 'none'
    1: 'scheduled'
    2: 'surveillance_intervention'
    3: 'market_event'
    4: 'instrument_activation'
    5: 'instrument_expiration'
    6: 'recovery_in_process'
    10: 'regulatory'
    11: 'administrative'
    12: 'non_compliance'
    13: 'filings_not_current'
    14: 'sec_trading_suspension'
    15: 'new_issue'
    16: 'issue_available'
    17: 'issues_reviewed'
    18: 'filing_reqs_satisfied'
    30: 'news_pending'
    31: 'news_released'
    32: 'news_and_resumption_times'
    33: 'news_not_forthcoming'
    40: 'order_imbalance'
    50: 'luld_pause'
    60: 'operational'
    70: 'additional_information_requested'
    80: 'merger_effective'
    90: 'etf'
    100: 'corporate_action'
    110: 'new_security_offering'
    120: 'market_wide_halt_level1'
    121: 'market_wide_halt_level2'
    122: 'market_wide_halt_level3'
    123: 'market_wide_halt_carryover'
    124: 'market_wide_halt_resumption'
    130: 'quotation_not_available'
  trading_event:
    0: 'none'
    1: 'no_cancel'
    2: 'change_trading_session'
    3: 'implied_matching_on'
    4: 'implied_matching_off'
  is_trading:
    0x7e: 'not_available'
    0x4e: 'no_field'
    0x59: 'yes_field'
  is_quoting:
    0x7e: 'not_available'
    0x4e: 'no_field'
    0x59: 'yes_field'
  is_short_sell_restricted:
    0x7e: 'not_available'
    0x4e: 'no_field'
    0x59: 'yes_field'
  instrument_class:
    0x42: 'bond'
    0x43: 'call'
    0x46: 'future'
    0x49: 'index'
    0x4b: 'stock'
    0x4d: 'mixed_spread'
    0x50: 'put'
    0x53: 'future_spread'
    0x54: 'option_spread'
    0x58: 'fx_spot'
    0x59: 'commodity_spot'
  match_algorithm:
    0x20: 'undefined'
    0x41: 'allocation'
    0x43: 'pro_rata'
    0x46: 'fifo'
    0x4b: 'configurable'
    0x4f: 'threshold_pro_rata'
    0x50: 'time_pro_rata'
    0x51: 'threshold_pro_rata_lmm'
    0x53: 'fifo_top_lmm'
    0x54: 'fifo_lmm'
    0x56: 'institutional_prioritization'
    0x59: 'eurodollar_futures'
  security_update_action:
    0x41: 'add'
    0x44: 'delete_field'
    0x4d: 'modify'
    0x7e: 'invalid'
  user_defined_instrument:
    0x4e: 'no_field'
    0x59: 'yes_field'
  unpaired_side:
    0x41:
      id: 'ask'
      doc: 'A sell order or sell aggressor in a trade'
    0x42:
      id: 'bid'
      doc: 'A buy order or a buy aggressor in a trade'
    0x4e:
      id: 'none'
      doc: 'No side specified by the original source'
  error_code:
    1: 'auth_failed'
    2: 'api_key_deactivated'
    3: 'connection_limit_exceeded'
    4: 'symbol_resolution_failed'
    5: 'invalid_subscription'
    6: 'internal_error'
    7: 'skipped_records_after_slow_reading'
    8: 'replay_data_aged_out'
    255: 'unset'
  system_code:
    0: 'heartbeat'
    1: 'subscription_ack'
    2: 'slow_reader_warning'
    3: 'replay_completed'
    4: 'end_of_interval'
    5: 'unsubscribe_ack'
    255: 'unset'
  stat_type:
    1: 'opening_price'
    2: 'indicative_opening_price'
    3: 'settlement_price'
    4: 'trading_session_low_price'
    5: 'trading_session_high_price'
    6: 'cleared_volume'
    7: 'lowest_offer'
    8: 'highest_bid'
    9: 'open_interest'
    10: 'fixing_price'
    11: 'close_price'
    12: 'net_change'
    13: 'vwap'
    14: 'volatility'
    15: 'delta'
    16: 'uncrossing_price'
    17: 'upper_price_limit'
    18: 'lower_price_limit'
    19: 'block_volume'
    20: 'indicative_close_price'
    21: 'mwcb_level1'
    22: 'mwcb_level2'
    23: 'mwcb_level3'
    24: 'auction_collar_reference_price'
    25: 'auction_collar_upper_price'
    26: 'auction_collar_lower_price'
    10001: 'venue_specific_volume1'
    10002: 'venue_specific_price1'
  update_action:
    1: 'new_field'
    2: 'delete_field'

