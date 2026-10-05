# ---------------------------------------------------------------------
# Kaitai struct definition for: Databento Historical Dbn v3
#
# Protocol:
#   Organization: Databento
#   Protocol: Historical
#   Encoding: Databento Binary Encoding
#   Version: 3
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
  id: databento_marketdata_historical_dbn_v3
  title: Databento Historical Dbn v3
  license: GPL-3.0
  endian: le

doc: 'Databento Databento Market Data Historical Dbn v3'
doc-ref:
  - https://databento.com/docs/standards-and-conventions/databento-binary-encoding
  - https://github.com/databento/dbn

seq:
  - id: metadata
    type: metadata_struct
    doc: 'DBN metadata header, once at the start of a file or stream'
  - id: record
    type: record_struct
    repeat: eos
    doc: 'A DBN record: the common header, the record its rtype selects, and the ts_out trailer when the metadata asks for it'

types:
  metadata_struct:
    seq:
      - id: magic
        type: str
        size: 3
        encoding: ASCII
        doc: 'The DBN magic string'
      - id: version
        type: u1
        doc: 'The DBN schema version number'
      - id: metadata_length
        type: u4
        doc: 'The length of the metadata after this field, in bytes'
      - id: dataset
        type: str
        size: 16
        encoding: ASCII
        doc: 'The dataset code'
      - id: schema
        type: u2_nullable
        doc: 'The data record schema; no value for a file of mixed schemas. Nullable, No Value = 65535'
      - id: start
        type: nanosecond_timestamp
        doc: 'The start time of query range in UNIX epoch nanoseconds. Nanoseconds since Unix epoch'
      - id: end
        type: nanosecond_timestamp_nullable
        doc: 'The end time of query range in UNIX epoch nanoseconds; no value when unbounded. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: limit
        type: u8_nullable
        doc: 'The maximum number of records to return; no value when unlimited. Nullable, No Value = 0'
      - id: stype_in
        type: u1_nullable
        doc: 'The input symbology type. Nullable, No Value = 255'
      - id: stype_out
        type: u1
        enum: stype_out
        doc: 'The output symbology type'
      - id: ts_out
        type: u1
        enum: ts_out
        doc: 'Whether every record carries a ts_out trailer, the live gateway send timestamp'
      - id: symbol_cstr_len
        type: u2
        doc: 'The number of bytes in fixed-length symbol strings, including a null terminator byte; 71 in version 3'
      - id: metadata_reserved
        size: 53
        doc: 'Reserved, 53 bytes'
      - id: len_schema_definition
        type: u4
        doc: 'The length of the schema definition; always 0'
      - id: schema_definition
        size: len_schema_definition
        doc: 'The schema definition; always empty'
      - id: num_symbol
        type: u4
        doc: 'The number of query input symbols'
      - id: symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'One of the query input symbols'
      - id: num_partial_symbol
        type: u4
        doc: 'The number of symbols that did not resolve for at least one day in the query time range'
      - id: partial_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'One of the symbols that did not resolve for at least one day in the query time range'
      - id: num_not_found_symbol
        type: u4
        doc: 'The number of symbols that did not resolve for any day in the query time range'
      - id: not_found_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'One of the symbols that did not resolve for any day in the query time range'
      - id: num_symbol_mapping
        type: u4
        doc: 'The number of symbol mappings'
      - id: symbol_mapping
        type: symbol_mapping
        repeat: expr
        repeat-expr: num_symbol_mapping
        doc: 'The mappings of one raw symbol'
      - id: metadata_padding
        size: metadata_length + 8 - 495
        doc: 'Padding to an 8 byte boundary'
  symbol_mapping:
    seq:
      - id: raw_symbol_in
        type: str
        size: 71
        encoding: ASCII
        doc: 'The symbol assigned by publisher'
      - id: num_mapping_interval
        type: u4
        doc: 'The number of mapping intervals of the symbol'
      - id: mapping_interval
        type: mapping_interval
        repeat: expr
        repeat-expr: num_mapping_interval
        doc: 'The resolution of a symbol for a date range'
  mapping_interval:
    seq:
      - id: start_date
        type: u4
        doc: 'The UTC start date of the mapping interval, as a YYYYMMDD integer'
      - id: end_date
        type: u4
        doc: 'The UTC end date of the mapping interval, as a YYYYMMDD integer'
      - id: mapped_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'The resolved symbol for this interval'
  record_struct:
    seq:
      - id: record_header
        type: record_header
        doc: 'DBN common header of every record'
      - id: record_body
        size: record_header.record_length * 4 - 24
        type:
          switch-on: record_header.rtype
          cases:
            'rtype::market_by_price_0': trade_msg
            'rtype::market_by_price_1': mbp_1_msg
            'rtype::market_by_price_10': mbp_10_msg
            'rtype::ohlcv_deprecated': ohlcv_msg
            'rtype::status': status_msg
            'rtype::instrument_definition': instrument_def_msg
            'rtype::imbalance': imbalance_msg
            'rtype::error': error_msg
            'rtype::symbol_mapping': symbol_mapping_msg
            'rtype::system': system_msg
            'rtype::statistics': stat_msg
            'rtype::ohlcv_1_second': ohlcv_msg
            'rtype::ohlcv_1_minute': ohlcv_msg
            'rtype::ohlcv_1_hour': ohlcv_msg
            'rtype::ohlcv_1_day': ohlcv_msg
            'rtype::ohlcv_end_of_day': ohlcv_msg
            'rtype::market_by_order': mbo_msg
            'rtype::consolidated_market_by_price_1': cmbp_1_msg
            'rtype::consolidated_bbo_1_second': cbbo_msg
            'rtype::consolidated_bbo_1_minute': cbbo_msg
            'rtype::trade_with_consolidated_bbo': cmbp_1_msg
            'rtype::bbo_1_second': bbo_msg
            'rtype::bbo_1_minute': bbo_msg
      - id: ts_out_time
        type: nanosecond_timestamp
        if: _root.metadata.ts_out == ts_out::yes_field
        doc: 'The live gateway send timestamp, present on every record when the metadata ts_out flag is set. Nanoseconds since Unix epoch'
  record_header:
    seq:
      - id: record_length
        type: u1
        doc: 'The length of the record in 32-bit words, including this header and any ts_out trailer'
      - id: rtype
        type: u1
        enum: rtype
        doc: 'The record type, which selects the record that follows the header'
      - id: publisher_id
        type: u2
        doc: 'The publisher ID assigned by Databento, which denotes the dataset and venue'
      - id: instrument_id
        type: u4
        doc: 'The numeric instrument ID'
      - id: ts_event
        type: nanosecond_timestamp_nullable
        doc: 'The matching-engine-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
  trade_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: action
        type: u1
        enum: action
        doc: 'The event action'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: depth
        type: u1
        doc: 'The book level where the update event occurred'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_flag
        type: b1
        doc: 'Bit 0, unused'
      - id: publisher_specific
        type: b1
        doc: 'Indicates a publisher-specific event (bit 1)'
      - id: maybe_bad_book
        type: b1
        doc: 'Indicates an unrecoverable gap was detected in the channel (bit 2)'
      - id: bad_ts_recv
        type: b1
        doc: 'Indicates the ts_recv value is inaccurate due to clock issues or packet reordering (bit 3)'
      - id: mbp
        type: b1
        doc: 'Indicates an aggregated price level message, not an individual order (bit 4)'
      - id: snapshot
        type: b1
        doc: 'Indicates the message was sourced from a replay, such as a snapshot server (bit 5)'
      - id: tob
        type: b1
        doc: 'Indicates a top-of-book message, not an individual order (bit 6)'
      - id: last
        type: b1
        doc: 'Marks the last record in a single event for a given instrument_id (bit 7)'
  mbp_1_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: action
        type: u1
        enum: action
        doc: 'The event action'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: depth
        type: u1
        doc: 'The book level where the update event occurred'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
      - id: bid_ask_pair
        type: bid_ask_pair
        doc: 'A level'
  bid_ask_pair:
    seq:
      - id: bid_px
        type: decimal_s8_9_nullable
        doc: 'The bid price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: ask_px
        type: decimal_s8_9_nullable
        doc: 'The ask price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: bid_sz
        type: u4
        doc: 'The bid size'
      - id: ask_sz
        type: u4
        doc: 'The ask size'
      - id: bid_ct
        type: u4
        doc: 'The number of bid orders'
      - id: ask_ct
        type: u4
        doc: 'The number of ask orders'
  mbp_10_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: action
        type: u1
        enum: action
        doc: 'The event action'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: depth
        type: u1
        doc: 'The book level where the update event occurred'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
      - id: bid_ask_pair
        type: bid_ask_pair
        repeat: expr
        repeat-expr: 10
        doc: 'A level'
  ohlcv_msg:
    seq:
      - id: open
        type: decimal_s8_9_nullable
        doc: 'The open price for the bar. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: high
        type: decimal_s8_9_nullable
        doc: 'The high price for the bar. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low
        type: decimal_s8_9_nullable
        doc: 'The low price for the bar. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: close
        type: decimal_s8_9_nullable
        doc: 'The close price for the bar. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: volume
        type: u8
        doc: 'The total volume traded during the aggregation period'
  status_msg:
    seq:
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: status_action
        type: u2
        enum: status_action
        doc: 'The type of status change'
      - id: status_reason
        type: u2
        enum: status_reason
        doc: 'Additional details about the cause of the status change'
      - id: trading_event
        type: u2
        enum: trading_event
        doc: 'Further information about a status update'
      - id: is_trading
        type: u1
        enum: is_trading
        doc: 'The state of trading in the instrument'
      - id: is_quoting
        type: u1
        enum: is_quoting
        doc: 'The state of quoting in the instrument'
      - id: is_short_sell_restricted
        type: u1
        enum: is_short_sell_restricted
        doc: 'The state of short sell restrictions for the instrument'
      - id: reserved_7
        size: 7
        doc: 'Reserved, 7 bytes'
  instrument_def_msg:
    seq:
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: min_price_increment
        type: decimal_s8_9_nullable
        doc: 'The min price increment, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: display_factor
        type: decimal_s8_9_nullable
        doc: 'The display factor, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: expiration
        type: nanosecond_timestamp_nullable
        doc: 'The last eligible trade time expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: activation
        type: nanosecond_timestamp_nullable
        doc: 'The time of instrument activation expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'The high limit price, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'The low limit price, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'The max price variation, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: unit_of_measure_qty
        type: decimal_s8_9_nullable
        doc: 'The unit of measure qty, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment_amount
        type: decimal_s8_9_nullable
        doc: 'The min price increment amount, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: price_ratio
        type: decimal_s8_9_nullable
        doc: 'The price ratio, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: strike_price
        type: decimal_s8_9_nullable
        doc: 'The strike price, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: raw_instrument_id
        type: u8
        doc: 'The instrument ID assigned by the publisher; may be the same as instrument_id'
      - id: leg_price
        type: decimal_s8_9_nullable
        doc: 'The leg price, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: leg_delta
        type: decimal_s8_9_nullable
        doc: 'The leg delta, where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: inst_attrib_value
        type: s4
        doc: 'A bitmap of instrument eligibility attributes; venue-specific'
      - id: underlying_id
        type: u4
        doc: 'The underlying id'
      - id: market_depth_implied
        type: s4
        doc: 'The market depth implied'
      - id: market_depth
        type: s4
        doc: 'The market depth'
      - id: market_segment_id
        type: u4
        doc: 'The market segment id'
      - id: max_trade_vol
        type: u4
        doc: 'The max trade vol'
      - id: min_lot_size
        type: s4
        doc: 'The min lot size'
      - id: min_lot_size_block
        type: s4
        doc: 'The min lot size block'
      - id: min_lot_size_round_lot
        type: s4
        doc: 'The min lot size round lot'
      - id: min_trade_vol
        type: u4
        doc: 'The min trade vol'
      - id: contract_multiplier
        type: s4
        doc: 'The contract multiplier'
      - id: decay_quantity
        type: s4
        doc: 'The decay quantity'
      - id: original_contract_size
        type: s4
        doc: 'The original contract size'
      - id: leg_instrument_id
        type: u4
        doc: 'The leg instrument id'
      - id: leg_ratio_price_numerator
        type: s4
        doc: 'The leg ratio price numerator'
      - id: leg_ratio_price_denominator
        type: s4
        doc: 'The leg ratio price denominator'
      - id: leg_ratio_qty_numerator
        type: s4
        doc: 'The leg ratio qty numerator'
      - id: leg_ratio_qty_denominator
        type: s4
        doc: 'The leg ratio qty denominator'
      - id: leg_underlying_id
        type: u4
        doc: 'The leg underlying id'
      - id: appl_id
        type: s2
        doc: 'The appl id'
      - id: maturity_year
        type: u2
        doc: 'The maturity year'
      - id: decay_start_date
        type: u2
        doc: 'The decay start date'
      - id: channel
        type: u2
        doc: 'The channel ID assigned by Databento as an incrementing integer starting at zero'
      - id: leg_count
        type: u2
        doc: 'The leg count'
      - id: leg_index
        type: u2
        doc: 'The leg index'
      - id: currency
        type: str
        size: 4
        encoding: ASCII
        doc: 'The currency'
      - id: settl_currency
        type: str
        size: 4
        encoding: ASCII
        doc: 'The settl currency'
      - id: secsubtype
        type: str
        size: 6
        encoding: ASCII
        doc: 'The secsubtype'
      - id: raw_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'The raw symbol'
      - id: group
        type: str
        size: 21
        encoding: ASCII
        doc: 'The group'
      - id: exchange
        type: str
        size: 5
        encoding: ASCII
        doc: 'The exchange'
      - id: asset
        type: str
        size: 11
        encoding: ASCII
        doc: 'The asset'
      - id: cfi
        type: str
        size: 7
        encoding: ASCII
        doc: 'The cfi'
      - id: security_type
        type: str
        size: 7
        encoding: ASCII
        doc: 'The security type'
      - id: unit_of_measure
        type: str
        size: 31
        encoding: ASCII
        doc: 'The unit of measure'
      - id: underlying
        type: str
        size: 21
        encoding: ASCII
        doc: 'The underlying'
      - id: strike_price_currency
        type: str
        size: 4
        encoding: ASCII
        doc: 'The strike price currency'
      - id: leg_raw_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'The leg raw symbol'
      - id: instrument_class
        type: u1
        enum: instrument_class
        doc: 'The classification of the instrument'
      - id: match_algorithm
        type: u1
        enum: match_algorithm
        doc: 'The matching algorithm used for the instrument, typically FIFO'
      - id: main_fraction
        type: u1
        doc: 'The main fraction'
      - id: price_display_format
        type: u1
        doc: 'The price display format'
      - id: sub_fraction
        type: u1
        doc: 'The sub fraction'
      - id: underlying_product
        type: u1
        doc: 'The underlying product'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Indicates if the instrument definition has been added, modified, or deleted'
      - id: maturity_month
        type: u1
        doc: 'The maturity month'
      - id: maturity_day
        type: u1
        doc: 'The maturity day'
      - id: maturity_week
        type: u1
        doc: 'The maturity week'
      - id: user_defined_instrument
        type: u1
        enum: user_defined_instrument
        doc: 'Indicates if the instrument is user defined'
      - id: contract_multiplier_unit
        type: s1
        doc: 'The contract multiplier unit'
      - id: flow_schedule_type
        type: s1
        doc: 'The flow schedule type'
      - id: tick_rule
        type: u1
        doc: 'The tick rule'
      - id: leg_instrument_class
        type: u1
        enum: leg_instrument_class
        doc: 'The classification of the leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side taken for the leg when purchasing the spread'
      - id: reserved_17
        size: 17
        doc: 'Reserved, 17 bytes'
  imbalance_msg:
    seq:
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ref_price
        type: decimal_s8_9_nullable
        doc: 'The price at which the imbalance shares are calculated. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: auction_time
        type: nanosecond_timestamp_nullable
        doc: 'Reserved for future use. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: cont_book_clr_price
        type: decimal_s8_9_nullable
        doc: 'The hypothetical auction-clearing price for both cross and continuous orders. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: auct_interest_clr_price
        type: decimal_s8_9_nullable
        doc: 'The hypothetical auction-clearing price for cross orders only. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: ssr_filling_price
        type: decimal_s8_9_nullable
        doc: 'Reserved for future use. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: ind_match_price
        type: decimal_s8_9_nullable
        doc: 'Reserved for future use. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: upper_collar
        type: decimal_s8_9_nullable
        doc: 'Reserved for future use. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: lower_collar
        type: decimal_s8_9_nullable
        doc: 'Reserved for future use. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: paired_qty
        type: u4
        doc: 'The quantity of shares that are eligible to be matched at ref_price'
      - id: total_imbalance_qty
        type: u4
        doc: 'The quantity of shares that are not paired at ref_price'
      - id: market_imbalance_qty
        type: u4
        doc: 'Reserved for future use'
      - id: unpaired_qty
        type: u4
        doc: 'Reserved for future use'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Venue-specific character code indicating the auction type; ~ when unused'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: auction_status
        type: u1
        doc: 'Reserved for future use'
      - id: freeze_status
        type: u1
        doc: 'Reserved for future use'
      - id: num_extensions
        type: u1
        doc: 'Reserved for future use'
      - id: unpaired_side
        type: u1
        enum: unpaired_side
        doc: 'Reserved for future use'
      - id: significant_imbalance
        type: str
        size: 1
        encoding: ASCII
        doc: 'Venue-specific character code; for Nasdaq, contains the raw Price Variation Indicator'
      - id: reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
  error_msg:
    seq:
      - id: err
        type: str
        size: 302
        encoding: ASCII
        doc: 'The error message'
      - id: error_code
        type: u1
        enum: error_code
        doc: 'The error code'
      - id: is_last
        type: u1
        doc: 'Sometimes multiple errors are sent together; 1 when this is the last in the series'
  symbol_mapping_msg:
    seq:
      - id: stype_in
        type: u1_nullable
        doc: 'The input symbology type. Nullable, No Value = 255'
      - id: stype_in_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'The input symbol'
      - id: stype_out
        type: u1
        enum: stype_out
        doc: 'The output symbology type'
      - id: stype_out_symbol
        type: str
        size: 71
        encoding: ASCII
        doc: 'The output symbol'
      - id: start_ts
        type: nanosecond_timestamp_nullable
        doc: 'The start of the mapping interval expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: end_ts
        type: nanosecond_timestamp_nullable
        doc: 'The end of the mapping interval expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
  system_msg:
    seq:
      - id: msg
        type: str
        size: 303
        encoding: ASCII
        doc: 'The message from the Databento Live Subscription Gateway (LSG)'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Type of system message'
  stat_msg:
    seq:
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_ref
        type: nanosecond_timestamp_nullable
        doc: 'The reference timestamp of the statistic value expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: quantity
        type: s8_nullable
        doc: 'The value for non-price statistics. Nullable, No Value = 9223372036854775807'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: stat_type
        type: u2
        enum: stat_type
        doc: 'The type of statistic value contained in the message'
      - id: channel
        type: u2
        doc: 'The channel ID assigned by Databento as an incrementing integer starting at zero'
      - id: update_action
        type: u1
        enum: update_action
        doc: 'Indicates if the statistic is newly added or deleted'
      - id: stat_flags
        type: u1
        doc: 'Additional flags associated with certain stat types'
      - id: reserved_18
        size: 18
        doc: 'Reserved, 18 bytes'
  mbo_msg:
    seq:
      - id: order_id
        type: u8
        doc: 'The order ID assigned at the venue'
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: channel_id
        type: u1
        doc: 'The channel ID assigned by Databento as an incrementing integer starting at zero'
      - id: action
        type: u1
        enum: action
        doc: 'The event action'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
  cmbp_1_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: action
        type: u1
        enum: action
        doc: 'The event action'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ts_in_delta
        type: s4
        doc: 'The matching-engine-sending timestamp expressed as the number of nanoseconds before ts_recv'
      - id: reserved_4
        size: 4
        doc: 'Reserved, 4 bytes'
      - id: consolidated_bid_ask_pair
        type: consolidated_bid_ask_pair
        doc: 'A price level consolidated from multiple venues'
  consolidated_bid_ask_pair:
    seq:
      - id: bid_px
        type: decimal_s8_9_nullable
        doc: 'The bid price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: ask_px
        type: decimal_s8_9_nullable
        doc: 'The ask price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: bid_sz
        type: u4
        doc: 'The bid size'
      - id: ask_sz
        type: u4
        doc: 'The ask size'
      - id: bid_pb
        type: u2
        doc: 'The publisher ID indicating the venue containing the best bid'
      - id: reserved_2
        size: 2
        doc: 'Reserved, 2 bytes'
      - id: ask_pb
        type: u2
        doc: 'The publisher ID indicating the venue containing the best ask'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved, 2 bytes'
  cbbo_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: reserved_8
        size: 8
        doc: 'Reserved, 8 bytes'
      - id: consolidated_bid_ask_pair
        type: consolidated_bid_ask_pair
        doc: 'A price level consolidated from multiple venues'
  bbo_msg:
    seq:
      - id: price
        type: decimal_s8_9_nullable
        doc: 'The price where every 1 unit corresponds to 1e-9. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: size
        type: u4
        doc: 'The order quantity'
      - id: reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
      - id: side
        type: u1
        enum: side
        doc: 'The side that initiates the event'
      - id: flags
        type: flags
        doc: 'A bit field indicating event end, message characteristics, and data quality; declared least significant bit first'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved, 1 byte'
      - id: ts_recv
        type: nanosecond_timestamp_nullable
        doc: 'The capture-server-received timestamp expressed as the number of nanoseconds since the UNIX epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: reserved_4
        size: 4
        doc: 'Reserved, 4 bytes'
      - id: sequence
        type: u4
        doc: 'The message sequence number assigned at the venue'
      - id: bid_ask_pair
        type: bid_ask_pair
        doc: 'A level'
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == 9223372036854775807

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
  leg_instrument_class:
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
  leg_side:
    0x41:
      id: 'ask'
      doc: 'A sell order or sell aggressor in a trade'
    0x42:
      id: 'bid'
      doc: 'A buy order or a buy aggressor in a trade'
    0x4e:
      id: 'none'
      doc: 'No side specified by the original source'
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

