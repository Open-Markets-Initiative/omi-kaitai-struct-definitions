# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw BondSpot Indices Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: BondSpot Indices
#   Encoding: Exchange Data Publisher
#   Version: 6.8
#   Date: 02/11/2020
#   Specification: WSE_CDE_XDP_Message_Specifications_v_68.pdf
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
  id: gpw_bondspot_indices_xdp_v6_8
  title: Gpw BondSpot Indices Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie BondSpot BondSpot Indices Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message_buffer
    type: message_buffer_struct
    size-eos: true
    doc: 'The packet''s message area: the messages it counts, or one ZliB block holding them'

types:
  packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the packet including the 16 byte packet header'
      - id: packet_type
        type: u2
        enum: packet_type
        doc: 'Identifier for the type of data contained in the packet. Section 1.1 states one value, 501 for Market Data messages, for every feed the document specifies'
      - id: packet_sequence_number
        type: u4
        doc: 'The packet sequence number, unique for each broadcast stream and used for gap detection. It increases serially and monotonically and is reset to 1 at the beginning of each trading day. It is unique for packets containing market data only, and heartbeats inherit it from the last market data packet or packet sequence number reset packet'
      - id: send_time
        type: u4
        doc: 'Timestamp in millisecond indicating the packet broadcast time. The number represents the number of milliseconds since midnight of the last Sunday 00:00 UTC, a weekly epoch no Epoch trait represents, so the field carries no epoch and a reader resolves the absolute time against the Sunday preceding the capture'
      - id: service_id
        type: u2
        doc: 'Numeric value identifying the broadcast stream. Section 1.1 states that the possible values are described in the XDP CDE Configuration document, a companion this specification does not reproduce, so no value set is declared here'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Indicates delivery method, and a client reads it to determine whether the packet is ZliB compressed'
      - id: number_msg_entries
        type: u1
        doc: 'The number of messages that are contained within the packet'
  message_buffer_struct:
    seq:
      - id: message
        type: message
        repeat: expr
        repeat-expr: _root.packet_header.number_msg_entries
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::real_time_index_message': real_time_index_message
            'message_type::index_summary_message': index_summary_message
            'message_type::index_portfolio_message': index_portfolio_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  real_time_index_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: index_level
        type: u4
        doc: 'The value of the last level for the index according to the definition provided in the IndexLevelCode (To be calculated with the LevelScaleCode)'
      - id: session_high
        type: u4
        doc: 'Index highest level of the day (To be calculated with the LevelScaleCode)'
      - id: session_low
        type: u4
        doc: 'Index lowest level of the day (To be calculated with the LevelScaleCode) (not including the opening index value at the level ''A'' and the average weighted index with level ''R'')'
      - id: ind_index_opening_portfolio
        type: u4
        doc: 'Indicator of the index opening portfolio W(t) (To be calculated with the LevelScaleCode) The percentage change of the value of the packages of the instruments, for which the quotation was set to the total value of the index portfolio'
      - id: percent_change_toi
        type: u4
        doc: 'Percentage change of TOI in relation to the value of the closing index from the previous session (To be calculated with the LevelScaleCode) The field is completed only for messages with the level ''8'', ''3'' and ''9'''
      - id: pct_change_index_val_prev_session
        type: u4
        doc: 'Percentage change of the index value in relation to the value of the closing index from the previous session (To be calculated with the LevelScaleCode) The field is completed for messages with level ''1'', ''A'', ''2'', ''C'' and ''5''during the index status „ZW" and „ZO". Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: pct_change_index_val_prev_year
        type: u4
        doc: 'Percentage change of the index value in relation to its value at the end of the previous year (To be calculated with the LevelScaleCode) The field is completed for messages with level ''5''during the index status „ZW" and „ZO". Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: toi
        type: u4
        doc: 'Theoretical opening index calculated during the index status „TO" (the field completed only for message with level ''8'') or during the index status „PO" (the field completed only for message with level ''3'' and ''9'')'
      - id: point_change
        type: u4
        doc: 'The point change of the index to the previous value of the index (To be calculated with the LevelScaleCode)'
      - id: value_trading
        type: u8
        doc: 'Value of trading in the instruments from the given index (To be calculated with the LevelScaleCode)'
      - id: index_value_bid
        type: u4
        doc: 'The calculated value of the buy index based on the best buy offers of instruments (To be calculated with the LevelScaleCode) The field is completed for messages with level ''3'', ''1'' and ''2'' till the end continuous trading phase'
      - id: index_value_ask
        type: u4
        doc: 'The calculated value of the sell index based on the best sell offers of instruments'
      - id: mid_spread_index
        type: u4
        doc: 'Arithmetic mean of the values of the fields: "Index value according to buy offers" and „Index value according to sell offers" (To be calculated with the LevelScaleCode) The field is completed for messages with level ''3'', ''1'' and ''2'' till the end continuous trading phase'
      - id: difference_central_spread
        type: u4
        doc: 'The point difference of central spread to the current value of index (To be calculated with the LevelScaleCode) The field is completed for messages with level ''1'' and ''2'' till the end continuous trading phase'
      - id: num_of_active_instruments
        type: u2
        doc: 'Number of instruments – participants of the index, for which the quotation was set during the session'
      - id: num_of_instr_of_decreasing_qt
        type: u2
        doc: 'The number of instruments from the index portfolio, whose quotation at the current session is lower than the reference quotation at the session on the previous day'
      - id: num_of_instr_of_increasing_qt
        type: u2
        doc: 'The number of instruments the from index portfolio, whose quotation at the current session is higher than the reference quotation at the session on the previous day'
      - id: num_of_instr_of_unchanged_qt
        type: u2
        doc: 'The number of instruments from the index portfolio, whose quotation at the current session did not change as compared with the closing quotation at the session on the previous day'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with values of the following fields : IndexLevel SessionHigh, SessionLow, IndIndexOpeningPortfolio, PercentChangeTOI, PctChangeIndexValPrevSession, PctChangeIndexValPrevYear, TOI, PointChange, ValueTrading, IndexValueBid, IndexValueAsk, MidSpreadIndex, DifferenceCentralSpread'
      - id: time_first_high
        type: hhmmss_ascii_time
        doc: 'The time at which the highest value of a given index was published for the first time'
      - id: time_first_low
        type: hhmmss_ascii_time
        doc: 'The time at which the lowest value of a given index was published for the first time'
      - id: index_status_indicator
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two letter marker informing about the index status at the time of publishing the message'
      - id: index_level_code
        type: u1
        enum: index_level_code
        doc: 'Index Level Code'
      - id: marker_percent_change_toi
        type: u1
        enum: marker_percent_change_toi
        doc: 'Marker for the percentage change of TOI in relation to the value of the closing index from the previous session'
      - id: marker_pct_chg_index_val_prev_sess
        type: str
        size: 1
        encoding: ASCII
        doc: 'The indicator for the point change of the current value of the index as compared with the previous index value'
      - id: marker_pct_chg_index_val_prev_year
        type: str
        size: 1
        encoding: ASCII
        doc: 'Marker for the percentage change of the index value in relation to its value at the end of the previous year'
      - id: marker_point_change
        type: u1
        enum: marker_point_change
        doc: 'Marker for the point change of the index to the current value of the index'
      - id: marker_difference_central_spread
        type: u1
        enum: marker_difference_central_spread
        doc: 'The marker for the point change between the central spread and the last published index value'
      - id: dissemination_frequency_marker
        type: u1
        enum: dissemination_frequency_marker
        doc: 'One letter marker determining, whether the information on index value will be published in the next message at a particular level'
  index_summary_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: closing_index_value
        type: u4
        doc: 'Closing index value (To be calculated with the LevelScaleCode)'
      - id: ind_opening_portfolio
        type: u4
        doc: 'Indicator of the opening of the index portfolio W(t) for closing index'
      - id: opening_index_value
        type: u4
        doc: 'Opening index value (To be calculated with the LevelScaleCode)'
      - id: session_high
        type: u4
        doc: 'Index highest level of the day (To be calculated with the LevelScaleCode)'
      - id: session_low
        type: u4
        doc: 'Index lowest level of the day (To be calculated with the LevelScaleCode) (not including the opening index value at the level ''A'' and the average weighted index with level ''R'')'
      - id: pct_chg_high_index_val_prev_session
        type: u4
        doc: 'Percentage change of the highest index value to the value of the closing index from the previous session (To be calculated with the LevelScaleCode) Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: pct_chg_low_index_val_prev_session
        type: u4
        doc: 'Percentage change of the lowest index value to the value of the closing index from the previous session (To be calculated with the LevelScaleCode) Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: pct_change_index_val_prev_session
        type: u4
        doc: 'Percentage change of the index value in relation to the value of the closing index from the previous session (To be calculated with the LevelScaleCode) The field is completed for messages with level ''1'', ''A'', ''2'', ''C'' and ''5''during the index status „ZW" and „ZO". Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: pct_change_index_val_prev_year
        type: u4
        doc: 'Percentage change of the index value in relation to its value at the end of the previous year (To be calculated with the LevelScaleCode) The field is completed for messages with level ''5''during the index status „ZW" and „ZO". Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: capitalisation_portfolio
        type: u4
        doc: 'Capitalisation of the portfolio for the closing index expressed in the currency of the index, on basis of which the closing index is calculated'
      - id: index_adjustment_coefficient
        type: u4
        doc: 'Index adjustment coefficient K(t) for the closing index (To be combined with IndexAdjustmentScaleCode)'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with values of the following fields : IndexLevel SessionHigh, SessionLow, IndIndexOpeningPortfolio, PercentChangeTOI, PctChangeIndexValPrevSession, PctChangeIndexValPrevYear, TOI, PointChange, ValueTrading, IndexValueBid, IndexValueAsk, MidSpreadIndex, DifferenceCentralSpread'
      - id: capitalisation_scale_code
        type: u1
        doc: 'To be combined with CapitalisationPortfolio Not used for strategy index (in 548 message the field ProductClassification filled in with value "M")'
      - id: index_adjustment_scale_code
        type: u1
        doc: 'To be combined with IndexAdjustmentCoefficient'
      - id: time_closing
        type: hhmmss_ascii_time
        doc: 'Time of the publication of the closing value of the index at a given session.. Format HHMMSS. Time use CET'
      - id: time_opening
        type: hhmmss_ascii_time
        doc: 'Time of the publication of the opening value of the index'
      - id: time_full_opening
        type: hhmmss_ascii_time
        doc: 'Time of the publication of the full opening value of the index portfolio for W(t) = 100%. The time of sending the message 546 with level ''B'' Format HHMMSS or zero in case the indicator W(t) has not reached 100%. Time use CET'
      - id: time_high
        type: hhmmss_ascii_time
        doc: 'Time of the publication of the highest value of the index'
      - id: time_low
        type: hhmmss_ascii_time
        doc: 'Time of the publication of the lowest value of the index'
      - id: marker_high
        type: u1
        enum: marker_high
        doc: 'Marker of the percentage change of the highest value of the index to the closing index value from the previous session'
      - id: marker_low
        type: u1
        enum: marker_low
        doc: 'Marker of the percentage change of the lowest value of the index to the closing index value from the previous session'
      - id: marker_closing_prev_session
        type: u1
        enum: marker_closing_prev_session
        doc: 'Marker of the percentage change of the index at a particular session to the closing index value from the previous session'
      - id: marker_closing_prev_year
        type: u1
        enum: marker_closing_prev_year
        doc: 'Marker of the percentage change of the closing value of the index to its value at the end of the previous year'
      - id: reserved_1
        size: 1
        doc: 'For future use'
  index_portfolio_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: index_adjustment_coefficient
        type: u4
        doc: 'Index adjustment coefficient K(t) for the closing index (To be combined with IndexAdjustmentScaleCode)'
      - id: level_cash_portfolio
        type: u4
        doc: 'Level in cash in portfolio For strategy indices (in 548 message the field ProductClassification filled in with value "S" or "L") the field is filled in with value of interbank reference rate adopted in the index calculation algorithm'
      - id: value_last_closing_index
        type: u4
        doc: 'Value of the last closing index / NAV value number of ETF units (To be combined with LevelScaleCode)'
      - id: number_of_components
        type: u2
        doc: 'Total number of instruments in the index / given product For strategy indices (in 548 message the field ProductClassification filled in with value "S" or "L") the field is filled in with number of days between current and previous session'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: index_adjustment_scale_code
        type: u1
        doc: 'To be combined with IndexAdjustmentCoefficient'
      - id: cash_portfolio_scale_code
        type: u1
        doc: 'To be combined with LevelCashPortfolio'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with values of the following fields : IndexLevel SessionHigh, SessionLow, IndIndexOpeningPortfolio, PercentChangeTOI, PctChangeIndexValPrevSession, PctChangeIndexValPrevYear, TOI, PointChange, ValueTrading, IndexValueBid, IndexValueAsk, MidSpreadIndex, DifferenceCentralSpread'
      - id: index_portfolio_component
        type: index_portfolio_component
        repeat: expr
        repeat-expr: 20
        doc: 'Characteristics of index portfolio / information product; block is repeated 20 times'
      - id: date_validity
        type: yyyymmdd_ascii_date
        doc: 'Date of validity of index portfolio / information product (YYYYMMDD)'
      - id: index_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index currency / information product currency'
      - id: index_status_indicator
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two letter marker informing about the index status at the time of publishing the message'
      - id: index_pres_seq
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index presentation sequence marker For other information product the field :filler'
      - id: mode_index_dissemination
        type: u1
        enum: mode_index_dissemination
        doc: 'Mode of index dissemination'
      - id: product_classification
        type: u1
        enum: product_classification
        doc: 'Information product classification'
      - id: opening_calc_formula
        type: u1
        enum: opening_calc_formula
        doc: 'Opening index calculation formula'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: toi_dissemination
        type: u1
        enum: toi_dissemination
        doc: 'TOI dissemination marker during TO index status'
      - id: spread_dissemination
        type: u1
        enum: spread_dissemination
        doc: 'Spread dissemination marker'
      - id: trading_value_publication
        type: u1
        enum: trading_value_publication
        doc: 'Trading value publication marker'
      - id: message_continuation
        type: u1
        enum: message_continuation
        doc: 'Message Continuation Marker'
      - id: reserved_2
        size: 2
        doc: 'For future use'
  index_portfolio_component:
    seq:
      - id: instrument_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code of the instrument'
      - id: instrument_abbrev_name
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated name of the instrument'
      - id: instrument_packet
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument packet in index portfolio / of information product'
  millisecond_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i

enums:
  packet_type:
    501:
      id: 'market_data_messages'
      doc: 'Market Data messages'
  delivery_flag:
    0:
      id: 'real_time_message_uncompressed'
      doc: 'Real Time message (Uncompressed)'
    2:
      id: 'retransmission_message_uncompressed'
      doc: 'Retransmission message (Uncompressed)'
    16:
      id: 'real_time_message_zlib_compressed'
      doc: 'Real Time message (ZliB Compressed)'
    17:
      id: 'refresh_message_zlib_compressed'
      doc: 'Refresh message (ZliB Compressed)'
    18:
      id: 'retransmission_message_compressed'
      doc: 'Retransmission message (Compressed)'
  message_type:
    546:
      id: 'real_time_index_message'
      doc: 'The real time index message handles the real-time characteristics of an index'
    547:
      id: 'index_summary_message'
      doc: 'The index summary message provides a summary of the data calculated in a stock index for a given day'
    548:
      id: 'index_portfolio_message'
      doc: 'Index portfolio'
  system_id:
    1:
      id: 'all_non_utp_systems'
      doc: 'All Non Utp Systems'
    11:
      id: 'utp_trading_unit_1'
      doc: 'Utp Trading Unit 1'
    12:
      id: 'utp_trading_unit_2'
      doc: 'Utp Trading Unit 2'
  index_level_code:
    0x31:
      id: 'first_value_of_the_index_at_the_session'
      doc: 'First Value Of The Index At The Session'
    0x32:
      id: 'current_index'
      doc: 'Current Index'
    0x33:
      id: 'theoretical_value_of_the_index_before_its_opening'
      doc: 'Theoretical Value Of The Index Before Its Opening'
    0x35:
      id: 'closing_index_from_previous_session_reference_index'
      doc: 'Closing Index From Previous Session Reference Index'
    0x38:
      id: 'theoretical_opening_index_before_opening_the_session'
      doc: 'Theoretical Opening Index Before Opening The Session'
    0x39:
      id: 'index_without_opening'
      doc: 'Index Without Opening'
    0x41:
      id: 'preliminary_opening_index'
      doc: 'Preliminary Opening Index'
    0x42:
      id: 'synthetic_opening_index_100'
      doc: 'Synthetic Opening Index 100%'
    0x43:
      id: 'final_opening_index'
      doc: 'Final Opening Index'
    0x52:
      id: 'average_weighted_index'
      doc: 'Average Weighted Index'
    0x58:
      id: 'cancellation_of_the_current_values_of_the_index'
      doc: 'Cancellation Of The Current Values Of The Index'
    0x59:
      id: 'recalculated_current_values_of_the_index'
      doc: 'Recalculated Current Values Of The Index'
  marker_percent_change_toi:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  marker_point_change:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  marker_difference_central_spread:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  dissemination_frequency_marker:
    0x30:
      id: 'when_the_message_at_a_particular_level_is_published_regularly_at_the_session'
      doc: 'When The Message At A Particular Level Is Published Regularly At The Session'
    0x31:
      id: 'when_the_message_at_a_particular_level_is_published_at_the_session_on_a_one_time_basis'
      doc: 'When The Message At A Particular Level Is Published At The Session On A One Time Basis'
  marker_high:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  marker_low:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  marker_closing_prev_session:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  marker_closing_prev_year:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  mode_index_dissemination:
    0x43:
      id: 'index_is_quoted_in_determined_time_intervals'
      doc: 'Index Is Quoted In Determined Time Intervals'
    0x46:
      id: 'index_is_quoted_on_determined_hours'
      doc: 'Index Is Quoted On Determined Hours'
  product_classification:
    0x57:
      id: 'wse_index_from_the_main_market'
      doc: 'Wse Index From The Main Market'
    0x5a:
      id: 'external_index'
      doc: 'External Index'
    0x56:
      id: 'another_wse_information_product'
      doc: 'Another Wse Information Product'
    0x4d:
      id: 'wse_strategy_dividend_point_index'
      doc: 'Wse Strategy Dividend Point Index'
    0x53:
      id: 'wse_strategy_index_of_short_type'
      doc: 'Wse Strategy Index Of Short Type'
    0x4c:
      id: 'wse_strategy_index_of_leverage_type'
      doc: 'Wse Strategy Index Of Leverage Type'
  opening_calc_formula:
    0x53:
      id: 'synthetic'
      doc: 'Synthetic'
    0x4f:
      id: 'chronological'
      doc: 'Chronological'
  toi_dissemination:
    0x59:
      id: 'message_546_with_level_8_is_sent'
      doc: 'Message 546 With Level 8 Is Sent'
    0x4e:
      id: 'message_546_with_level_8_is_not_sent'
      doc: 'Message 546 With Level 8 Is Not Sent'
  spread_dissemination:
    0x59:
      id: 'spread_indicators_are_published'
      doc: 'Spread Indicators Are Published'
    0x4e:
      id: 'spread_indicators_are_not_published'
      doc: 'Spread Indicators Are Not Published'
  trading_value_publication:
    0x59:
      id: 'value_is_provided'
      doc: 'Value Is Provided'
    0x4e:
      id: 'value_is_not_provided'
      doc: 'Value Is Not Provided'
  message_continuation:
    0x30:
      id: 'the_message_is_not_the_last_message_information_of_the_composition_of_the_index_portfolio'
      doc: 'The Message Is Not The Last Message Information Of The Composition Of The Index Portfolio'
    0x31:
      id: 'the_message_is_the_last_message_information_of_the_composition_of_the_index_portfolio'
      doc: 'The Message Is The Last Message Information Of The Composition Of The Index Portfolio'

