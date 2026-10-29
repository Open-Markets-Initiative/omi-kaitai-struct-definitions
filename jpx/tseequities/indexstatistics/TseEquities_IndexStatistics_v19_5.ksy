# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx TseEquities IndexStatistics Flex v19.5
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: IndexStatistics
#   Encoding: Flex
#   Version: 19.5
#   Date: 09/25/2026
#   Specification: 03_FLEX Connection Specification Index Statistics group DS.19.0.pdf
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
  id: jpx_tseequities_indexstatistics_flex_v19_5
  title: Jpx TseEquities IndexStatistics Flex v19.5
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Tokyo Stock Exchange Equities IndexStatistics Flex v19.5'

seq:
  - id: start_of_message
    type: u1
    doc: 'Control Code DC1 (0x11), Start of a message'
  - id: service_header
    type: service_header_struct
    doc: 'Jpx Flex 39 byte service header, common to all message types'
  - id: separation_between_service_header_and_data_section
    type: u1
    doc: 'Control Code DC2 (0x12), Separation between Service Header and Data Section'
  - id: tag_information
    type: tag_information_struct
    repeat: eos
    doc: 'One tag: its two character Tag ID, its data, and the control code that closes it (DC3 between tags, DC1 at the end of the message)'

types:
  service_header_struct:
    seq:
      - id: message_length
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total Length: Control Code (DC1 and DC2) + Service Header Section + User Data Section (including DC3). Right-align the data, suppress space in the leading space'
      - id: message_serial_no
        type: message_serial_no
        doc: 'Numbered from 1 on each Multicast Group, with the multicast group number in the first to third byte'
      - id: message_type
        type: message_type
        doc: 'Large Classification indicates Message Type, and Medium Classification indicates details and other information'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Exchange the information belongs to. This section is a space in Control Message'
      - id: session_distinction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the session in which the new information is generated. Set in Issue Real-time Message (FLEX Standard, ToSTNeT) and Index Message; for Issue Basic Message, Statistics Message and Control Message, spaces is set'
      - id: issue_classification
        type: issue_classification
        doc: 'Set in issue realtime message and issue basic message. In the case of Control, Index and Statistics Message, space is set'
      - id: issue_code
        type:
          switch-on: issue_classification.issue_classification_large_classification
          cases:
            '"01"': stock_issue_code
            '"02"': cb_issue_code
  message_serial_no:
    seq:
      - id: multicast_group_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Multicast group number, set in the first to third byte of the Message Serial No'
      - id: sequence_number
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Numbered in sequence, beginning with 00000001. Space is set in the case of Backup Information, All-Day Information or Issue Basic Information, and the requested serial number which was used for the UDP message is set in Retransmission'
  message_type:
    seq:
      - id: message_type_large_classification
        type: u1
        enum: message_type_large_classification
        doc: 'Large Classification indicates Message Type'
      - id: message_type_medium_classification
        type:
          switch-on: message_type_large_classification
          cases:
            'message_type_large_classification::issue_realtime_message': issue_realtime_medium_classification_value
            'message_type_large_classification::statistics_message': statistics_medium_classification_value
            'message_type_large_classification::index_message': index_medium_classification_value
            'message_type_large_classification::issue_basic_message': issue_basic_medium_classification_value
            'message_type_large_classification::control_message': control_medium_classification_value
  issue_classification:
    seq:
      - id: issue_classification_large_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Large Classification of the Issue Classification Code'
      - id: issue_classification_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of the Issue Classification Code. Its meaning depends on the Large Classification: under 01 Stock-Related, 11 Prime Market (Domestic Stock) through 23 TOKYO PRO Market (Foreign Stock); under 02 CB-Related, 11 CB / 13 SW / 14 Exchangeable Bond'
  stock_issue_code:
    seq:
      - id: stock_space
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Space'
      - id: stock_proper_name_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Proper Name Code'
      - id: stock_reserved_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved Code. Space is set on the reserved code of a Mother Stock'
  cb_issue_code:
    seq:
      - id: cb_space
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Space'
      - id: cb_reserved_code
        type: u1
        enum: cb_reserved_code
        doc: 'Reserved Code'
      - id: time_symbol
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time Symbol'
      - id: cb_proper_name_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Proper Name Code'
  tag_information_struct:
    seq:
      - id: tag_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Tag ID is numbered using 1 to 9 and A to Z. Different tags are used for different information classifications'
      - id: payload
        type:
          switch-on: tag_id
          cases:
            '"MV"': market_value_message
            '"YS"': simple_yield_message
            '"YW"': weighted_yield_message
            '"AP"': simple_stock_price_average_message
            '"AW"': weighted_stock_price_average_message
            '"AT"': simple_stock_price_average_by_industry_message
            '"IY"': japanese_yen_cb_indicator_message
            '"NC"': number_of_gainers_decliners_message
            '"TV"': estimated_total_trading_volume_message
            '"TA"': estimated_total_turnover_message
            '"VS"': vwap_by_market_message
            '"RO"': ranking_by_trading_volume_message
            '"RA"': ranking_by_turnover_message
            '"RC"': ranking_by_net_change_message
            '"RP"': ranking_by_net_change_rate_message
            '"TS"': tostnet_statistics_message
            '"4I"': index_open_high_low_and_closing_prices_message
            '"SQ"': special_quotation_message
            '"LC"': control_message
      - id: separation_of_tag
        type: u1
        enum: separation_of_tag
        doc: 'Control Code DC3 (0x13) between tags, or DC1 (0x11) on the tag that ends the message'
  market_value_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: time_c_6_hhmm
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: total_market_value
        type: total_market_value
        doc: 'Total market value'
      - id: market_value_day_on_day_comparison
        type: market_value_day_on_day_comparison
        doc: 'Market value Day-on-day comparison'
  total_market_value:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: total_market_value_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total market value. The unit used for the computation is 1 million yen. Implied decimal with scale 1e-4'
  market_value_day_on_day_comparison:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: day_on_day_comparison_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the total market value (after adjustment) from the previous day. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  simple_yield_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: time_c_6_hhmm
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: simple_yield
        type: simple_yield
        doc: 'Simple yield'
      - id: yield_day_on_day_comparison
        type: yield_day_on_day_comparison
        doc: 'Yield Day-on-day comparison'
  simple_yield:
    seq:
      - id: simple_yield_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the simple yield. Unit: 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  yield_day_on_day_comparison:
    seq:
      - id: day_on_day_comparison_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the final yield from the previous day. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  weighted_yield_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: time_c_6_hhmm
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: weighted_yield
        type: weighted_yield
        doc: 'Weighted yield'
      - id: yield_day_on_day_comparison
        type: yield_day_on_day_comparison
        doc: 'Yield Day-on-day comparison'
  weighted_yield:
    seq:
      - id: weighted_yield_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the weighted yield. Unit: 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  simple_stock_price_average_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: simple_stock_price_average
        type: simple_stock_price_average
        doc: 'Simple stock price average'
      - id: stock_price_average_day_on_day_comparison
        type: stock_price_average_day_on_day_comparison
        doc: 'Stock price average Day-on-day comparison'
  simple_stock_price_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: simple_stock_price_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the simple stock price average. The unit used for the computation is 1/100 yen (i.e., sen). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  stock_price_average_day_on_day_comparison:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: day_on_day_comparison_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the total market value (after adjustment) from the previous day. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  weighted_stock_price_average_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: weighted_stock_price_average
        type: weighted_stock_price_average
        doc: 'Weighted stock price average'
      - id: stock_price_average_day_on_day_comparison
        type: stock_price_average_day_on_day_comparison
        doc: 'Stock price average Day-on-day comparison'
  weighted_stock_price_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: weighted_stock_price_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the weighted stock price average. The unit used for the computation is 1/100 yen (i.e., sen). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  simple_stock_price_average_by_industry_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: industry_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This tag will also be sent for industries without issues'
      - id: simple_stock_price_average
        type: simple_stock_price_average
        doc: 'Simple stock price average'
      - id: stock_price_average_day_on_day_comparison
        type: stock_price_average_day_on_day_comparison
        doc: 'Stock price average Day-on-day comparison'
  japanese_yen_cb_indicator_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: overall
        type: overall
        doc: 'Overall'
      - id: parity_100_or_higher
        type: parity_100_or_higher
        doc: 'Parity 100 or higher'
      - id: parity_less_than_100
        type: parity_less_than_100
        doc: 'Parity less than 100'
  overall:
    seq:
      - id: overall_simple_average
        type: overall_simple_average
        doc: 'Overall Simple average'
      - id: overall_divergence_average
        type: overall_divergence_average
        doc: 'Overall Divergence average'
      - id: overall_parity_average
        type: overall_parity_average
        doc: 'Overall Parity average'
      - id: overall_direct_yield_average
        type: overall_direct_yield_average
        doc: 'Overall Direct yield average'
  overall_simple_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: simple_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the simple average. The unit used for the computation is 1/100 yen (i.e., sen). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: second_unit_flag
        type: u1
        enum: second_unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: day_on_day_comparison_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the total market value (after adjustment) from the previous day. Implied decimal with scale 1e-4'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  overall_divergence_average:
    seq:
      - id: divergence_average_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the divergence average. The unit is 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: day_on_day_comparison_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the final yield from the previous day. Implied decimal with scale 1e-2'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  overall_parity_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: parity_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the parity average. The unit used for the computation is 1/100 points. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: second_unit_flag
        type: u1
        enum: second_unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: day_on_day_comparison_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the total market value (after adjustment) from the previous day. Implied decimal with scale 1e-4'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  overall_direct_yield_average:
    seq:
      - id: direct_yield_average_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the direct yield. The unit is 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: day_on_day_comparison_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the final yield from the previous day. Implied decimal with scale 1e-2'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  parity_100_or_higher:
    seq:
      - id: simple_average
        type: simple_average
        doc: 'Simple average'
      - id: divergence_average
        type: divergence_average
        doc: 'Divergence average'
      - id: parity_average
        type: parity_average
        doc: 'Parity average'
      - id: direct_yield_average
        type: direct_yield_average
        doc: 'Direct yield average'
  simple_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: simple_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the simple average. The unit used for the computation is 1/100 yen (i.e., sen). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  divergence_average:
    seq:
      - id: divergence_average_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the divergence average. The unit is 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  parity_average:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: parity_average_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the parity average. The unit used for the computation is 1/100 points. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  direct_yield_average:
    seq:
      - id: direct_yield_average_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the direct yield. The unit is 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
  parity_less_than_100:
    seq:
      - id: simple_average
        type: simple_average
        doc: 'Simple average'
      - id: divergence_average
        type: divergence_average
        doc: 'Divergence average'
      - id: parity_average
        type: parity_average
        doc: 'Parity average'
      - id: direct_yield_average
        type: direct_yield_average
        doc: 'Direct yield average'
  number_of_gainers_decliners_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: number_of_listed_companies
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of listed companies. Unit: company'
      - id: number_of_listed_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of listed issues. Unit: issue'
      - id: number_of_active_issues
        type: number_of_active_issues
        doc: 'Number of active issues'
      - id: number_of_gainers
        type: number_of_gainers
        doc: 'Number of gainers'
      - id: number_of_decliners
        type: number_of_decliners
        doc: 'Number of decliners'
      - id: number_of_issues_with_no_change
        type: number_of_issues_with_no_change
        doc: 'Number of issues with no change'
      - id: number_of_issues_with_no_comparison
        type: number_of_issues_with_no_comparison
        doc: 'Number of issues with no comparison'
      - id: number_of_inactive_issues
        type: number_of_inactive_issues
        doc: 'Number of inactive issues'
  number_of_active_issues:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  number_of_gainers:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  number_of_decliners:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  number_of_issues_with_no_change:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  number_of_issues_with_no_comparison:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  number_of_inactive_issues:
    seq:
      - id: number_of_issues
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: issue'
      - id: ratio
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unit: 1/100%. Implied decimal with scale 1e-2'
  estimated_total_trading_volume_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: other_classification_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the classifications that are not included in the issue classification codes'
      - id: estimated_total_trading_volume
        type: estimated_total_trading_volume
        doc: 'Estimated total trading volume'
  estimated_total_trading_volume:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: estimated_total_trading_volume_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the estimated total trading volume for each issue classification'
  estimated_total_turnover_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: other_classification_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the classifications that are not included in the issue classification codes'
      - id: estimated_total_turnover
        type: estimated_total_turnover
        doc: 'Estimated total turnover'
  estimated_total_turnover:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: estimated_total_turnover_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the estimated total turnover'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved for future use'
  vwap_by_market_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: vwap_by_market
        type: vwap_by_market
        doc: 'VWAP by market'
  vwap_by_market:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: vwap_by_market_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the VWAP by market. Unit used for computation: 1/100 yen. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved for future use'
      - id: second_unit_flag
        type: u1
        enum: second_unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: day_on_day_comparison_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the change in the total market value (after adjustment) from the previous day. Implied decimal with scale 1e-4'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  ranking_by_trading_volume_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: top_rank_by_trading_volume
        type: top_rank_by_trading_volume
        repeat: expr
        repeat-expr: 30
        doc: 'Top rank by trading volume'
  top_rank_by_trading_volume:
    seq:
      - id: rank
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the rank'
      - id: ranked_issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue code'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved for future use'
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: trading_volume_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trading volume'
  ranking_by_turnover_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: top_rank_by_turnover
        type: top_rank_by_turnover
        repeat: expr
        repeat-expr: 30
        doc: 'Top rank by turnover'
  top_rank_by_turnover:
    seq:
      - id: rank
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the rank'
      - id: ranked_issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue code'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved for future use'
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: turnover_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the turnover'
  ranking_by_net_change_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: net_change_distinction
        type: u1
        enum: net_change_distinction
        doc: 'Indicates the distinction between net change'
      - id: top_rank_by_net_change
        type: top_rank_by_net_change
        repeat: expr
        repeat-expr: 30
        doc: 'Top rank by net change'
  top_rank_by_net_change:
    seq:
      - id: rank
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the rank'
      - id: ranked_issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue code'
      - id: state_sign
        type: u1
        enum: state_sign
        doc: 'Indicates the state of the current price'
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: current_price_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the current price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: comparison_type
        type: u1
        enum: comparison_type
        doc: 'Indicates comparison type'
      - id: second_unit_flag
        type: u1
        enum: second_unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: net_change
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the net change. Implied decimal with scale 1e-4'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  ranking_by_net_change_rate_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: issue_classification_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue classification code'
      - id: net_change_distinction
        type: u1
        enum: net_change_distinction
        doc: 'Indicates the distinction between net change'
      - id: top_rank_by_net_change_rate
        type: top_rank_by_net_change_rate
        repeat: expr
        repeat-expr: 30
        doc: 'Top rank by net change rate'
  top_rank_by_net_change_rate:
    seq:
      - id: rank
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the rank'
      - id: ranked_issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue code'
      - id: state_sign
        type: u1
        enum: state_sign
        doc: 'Indicates the state of the current price'
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: current_price_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the current price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: comparison_type
        type: u1
        enum: comparison_type
        doc: 'Indicates comparison type'
      - id: net_change_rate
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates net change rate. The unit will be 1/100%. Implied decimal with scale 1e-2'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  tostnet_statistics_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: output_time
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
      - id: other_classification_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the classifications that are not included in the issue classification codes'
      - id: trading_volume
        type: trading_volume
        doc: 'Trading volume'
      - id: turnover
        type: turnover
        doc: 'Turnover'
      - id: number_of_transactions
        type: number_of_transactions
        doc: 'Number of transactions'
  trading_volume:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: single_issue_transaction_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for single-issue transactions'
      - id: second_trading_volumeturnover_unit_flag
        type: u1
        enum: second_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: closing_price_transaction
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for closing price transactions'
      - id: third_trading_volumeturnover_unit_flag
        type: u1
        enum: third_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: basket_transaction_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for basket transactions'
      - id: fourth_trading_volumeturnover_unit_flag
        type: u1
        enum: fourth_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: aggregate_trading_volume
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the aggregate of trading volume for transactions conducted on ToSTNeT'
  turnover:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: single_issue_transaction_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for single-issue transactions'
      - id: second_trading_volumeturnover_unit_flag
        type: u1
        enum: second_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: closing_price_transaction
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for closing price transactions'
      - id: third_trading_volumeturnover_unit_flag
        type: u1
        enum: third_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: basket_transaction_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total of trading volumes for basket transactions'
      - id: fourth_trading_volumeturnover_unit_flag
        type: u1
        enum: fourth_trading_volumeturnover_unit_flag
        doc: 'Indicates the unit of the turnover'
      - id: aggregate_turnover
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the aggregate of turnovers for transactions conducted on the ToSTNeT'
  number_of_transactions:
    seq:
      - id: single_issue_transaction_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of single-issue transactions. Unit: transaction'
      - id: basket_transaction_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of basket transactions'
  index_open_high_low_and_closing_prices_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: index_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of index'
      - id: open
        type: open
        doc: 'Open'
      - id: highest
        type: highest
        doc: 'Highest'
      - id: lowest
        type: lowest
        doc: 'Lowest'
      - id: current_price
        type: current_price
        doc: 'Current price'
      - id: index_day_on_day_comparison
        type: index_day_on_day_comparison
        doc: 'Index Day-on-day comparison'
  open:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: index_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the opening price of the index. Unit used for computation: 1/100 (the second decimal places will be set). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: time_c_6_hhmmss
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the opening price was computed'
      - id: flag
        type: u1
        enum: flag
        doc: 'Indicates the flag of the opening price'
  highest:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: index_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the opening price of the index. Unit used for computation: 1/100 (the second decimal places will be set). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: time_c_6_hhmmss
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the opening price was computed'
      - id: flag
        type: u1
        enum: flag
        doc: 'Indicates the flag of the opening price'
  lowest:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: index_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the opening price of the index. Unit used for computation: 1/100 (the second decimal places will be set). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: time_c_6_hhmmss
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the opening price was computed'
      - id: flag
        type: u1
        enum: flag
        doc: 'Indicates the flag of the opening price'
  current_price:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: index_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the opening price of the index. Unit used for computation: 1/100 (the second decimal places will be set). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: time_c_6_hhmmss
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the opening price was computed'
      - id: flag
        type: u1
        enum: flag
        doc: 'Indicates the flag of the opening price'
  index_day_on_day_comparison:
    seq:
      - id: net_change_rate
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates net change rate. The unit will be 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: net_change
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the net change. Implied decimal with scale 1e-4'
      - id: second_sign
        type: u1
        enum: second_sign
        doc: 'Indicates the sign of Day-on-day comparison'
  special_quotation_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: sq_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of S.Q'
      - id: index
        type: index
        doc: 'Index'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved for future use'
  index:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates that this is the unit flag'
      - id: index_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the opening price of the index. Unit used for computation: 1/100 (the second decimal places will be set). Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the sign of Day-on-day comparison'
      - id: time_c_6_hhmmss
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the opening price was computed'
  control_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: test_mode_flag
        type: u1
        enum: test_mode_flag
        doc: 'Indicates the flag for identifying the distinction between real and test operation'
      - id: startend_flag
        type: u1
        enum: startend_flag
        doc: 'Indicates the flag for identifying the distinction between start and end'
      - id: time_c_6_hhmm
        type: hhmm_ascii_time
        doc: 'Indicates the time of computation'
  issue_realtime_medium_classification_value:
    seq:
      - id: issue_realtime_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of a Issue Realtime Message. Indicates details and other information'
  statistics_medium_classification_value:
    seq:
      - id: statistics_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of a Statistics Message. Indicates details and other information'
  index_medium_classification_value:
    seq:
      - id: index_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of a Index Message. Indicates details and other information'
  issue_basic_medium_classification_value:
    seq:
      - id: issue_basic_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of a Issue Basic Message. Indicates details and other information'
  control_medium_classification_value:
    seq:
      - id: control_medium_classification
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Medium Classification of a Control Message. Indicates details and other information'
  hhmm_ascii_time:
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

enums:
  message_type_large_classification:
    0x31:
      id: 'issue_realtime_message'
      doc: 'New, Backup or All-Day issue realtime information'
    0x32:
      id: 'statistics_message'
      doc: 'Statistics information'
    0x33:
      id: 'index_message'
      doc: 'Index information'
    0x34:
      id: 'issue_basic_message'
      doc: 'Regular or Special issue basic information'
    0x39:
      id: 'control_message'
      doc: 'Communication, information and health check control'
  exchange_code:
    0x31: 'tokyo_stock_exchange'
    0x33: 'nagoya_stock_exchange'
    0x36: 'fukuoka_stock_exchange'
    0x38: 'sapporo_securities_exchange'
    0x30:
      id: 'other'
      doc: 'Do not use for the time being'
    0x20:
      id: 'control_message'
      doc: 'This section is a space in Control Message'
  cb_reserved_code:
    0x34: 'sw'
    0x38:
      id: 'exchangeable_bond'
      doc: 'Exchangeable bond (EB)'
    0x39: 'cb'
    0x20:
      id: 'other_bond'
      doc: 'Bond other than the above'
  trading_volume_turnover_unit_flag:
    0x30:
      id: 'one'
      doc: '10^0 = 1'
    0x31:
      id: 'ten'
      doc: '10^1 = 10'
    0x32:
      id: 'hundred'
      doc: '10^2 = 100'
    0x33:
      id: 'thousand'
      doc: '10^3 = 1000'
    0x34:
      id: 'ten_thousand'
      doc: '10^4 = 10000'
    0x35:
      id: 'hundred_thousand'
      doc: '10^5 = 100000'
    0x36:
      id: 'million'
      doc: '10^6 = 1000000'
    0x37:
      id: 'ten_million'
      doc: '10^7 = 10000000'
    0x38:
      id: 'hundred_million'
      doc: '10^8 = 100000000'
    0x39:
      id: 'billion'
      doc: '10^9 = 1000000000'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces will be set if the numerical part are spaces.'
  sign:
    0x2b:
      id: 'positive'
      doc: 'Set on a value, and on a Day-on-day comparison that rose.'
    0x2d:
      id: 'negative'
      doc: 'Set on a Day-on-day comparison that fell.'
    0x20:
      id: 'no_sign'
      doc: 'When the numerical part is all-space, the sign will be space.'
  unit_flag:
    0x30:
      id: 'to_the_fourth_decimal_place'
      doc: 'All the decimal places are valid.'
    0x31:
      id: 'to_the_third_decimal_place'
      doc: 'The fourth decimal place is always zero.'
    0x32:
      id: 'to_the_second_decimal_place'
      doc: 'The third and fourth decimal places are always zero.'
    0x33:
      id: 'to_the_first_decimal_place'
      doc: 'The second, third and fourth decimal places are always zero.'
    0x34:
      id: 'no_decimal_places'
      doc: 'All the decimal places are zero.'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces are set if the numerical part are set to spaces.'
  second_unit_flag:
    0x30:
      id: 'to_the_fourth_decimal_place'
      doc: 'All the decimal places are valid.'
    0x31:
      id: 'to_the_third_decimal_place'
      doc: 'The fourth decimal place is always zero.'
    0x32:
      id: 'to_the_second_decimal_place'
      doc: 'The third and fourth decimal places are always zero.'
    0x33:
      id: 'to_the_first_decimal_place'
      doc: 'The second, third and fourth decimal places are always zero.'
    0x34:
      id: 'no_decimal_places'
      doc: 'All the decimal places are zero.'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces are set if the numerical part are set to spaces.'
  second_sign:
    0x2b:
      id: 'positive'
      doc: 'Set on a value, and on a Day-on-day comparison that rose.'
    0x2d:
      id: 'negative'
      doc: 'Set on a Day-on-day comparison that fell.'
    0x20:
      id: 'no_sign'
      doc: 'When the numerical part is all-space, the sign will be space.'
  net_change_distinction:
    0x31:
      id: 'up'
      doc: 'Up'
    0x32:
      id: 'down'
      doc: 'Down'
  state_sign:
    0x31:
      id: 'ask_special_quote'
      doc: 'Ask Special Quote'
    0x32:
      id: 'bid_special_quote'
      doc: 'Bid Special Quote'
    0x33:
      id: 'ask_continuous_execution_quote'
      doc: 'Ask Continuous Execution Quote'
    0x34:
      id: 'bid_continuous_execution_quote'
      doc: 'Bid Continuous Execution Quote'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  comparison_type:
    0x31:
      id: 'change_from_base_price_for_the_day'
      doc: 'Indicates the change from base price for the day.'
    0x20:
      id: 'change_from_the_last_price_from_the_previous_day'
      doc: 'Indicates the change from the last price from the previous day.'
  second_trading_volumeturnover_unit_flag:
    0x30:
      id: 'one'
      doc: '10^0 = 1'
    0x31:
      id: 'ten'
      doc: '10^1 = 10'
    0x32:
      id: 'hundred'
      doc: '10^2 = 100'
    0x33:
      id: 'thousand'
      doc: '10^3 = 1000'
    0x34:
      id: 'ten_thousand'
      doc: '10^4 = 10000'
    0x35:
      id: 'hundred_thousand'
      doc: '10^5 = 100000'
    0x36:
      id: 'million'
      doc: '10^6 = 1000000'
    0x37:
      id: 'ten_million'
      doc: '10^7 = 10000000'
    0x38:
      id: 'hundred_million'
      doc: '10^8 = 100000000'
    0x39:
      id: 'billion'
      doc: '10^9 = 1000000000'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces will be set if the numerical part are spaces.'
  third_trading_volumeturnover_unit_flag:
    0x30:
      id: 'one'
      doc: '10^0 = 1'
    0x31:
      id: 'ten'
      doc: '10^1 = 10'
    0x32:
      id: 'hundred'
      doc: '10^2 = 100'
    0x33:
      id: 'thousand'
      doc: '10^3 = 1000'
    0x34:
      id: 'ten_thousand'
      doc: '10^4 = 10000'
    0x35:
      id: 'hundred_thousand'
      doc: '10^5 = 100000'
    0x36:
      id: 'million'
      doc: '10^6 = 1000000'
    0x37:
      id: 'ten_million'
      doc: '10^7 = 10000000'
    0x38:
      id: 'hundred_million'
      doc: '10^8 = 100000000'
    0x39:
      id: 'billion'
      doc: '10^9 = 1000000000'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces will be set if the numerical part are spaces.'
  fourth_trading_volumeturnover_unit_flag:
    0x30:
      id: 'one'
      doc: '10^0 = 1'
    0x31:
      id: 'ten'
      doc: '10^1 = 10'
    0x32:
      id: 'hundred'
      doc: '10^2 = 100'
    0x33:
      id: 'thousand'
      doc: '10^3 = 1000'
    0x34:
      id: 'ten_thousand'
      doc: '10^4 = 10000'
    0x35:
      id: 'hundred_thousand'
      doc: '10^5 = 100000'
    0x36:
      id: 'million'
      doc: '10^6 = 1000000'
    0x37:
      id: 'ten_million'
      doc: '10^7 = 10000000'
    0x38:
      id: 'hundred_million'
      doc: '10^8 = 100000000'
    0x39:
      id: 'billion'
      doc: '10^9 = 1000000000'
    0x20:
      id: 'no_numerical_value'
      doc: 'Spaces will be set if the numerical part are spaces.'
  flag:
    0x31:
      id: 'final_index_flag'
      doc: 'The final index for this session.'
    0x33:
      id: 'final_index_correction_flag'
      doc: 'Indicates that this is a correction to the final index.'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  test_mode_flag:
    0x31:
      id: 'real_operation'
      doc: 'Real Operation'
    0x32:
      id: 'test_operation'
      doc: 'Test Operation'
  startend_flag:
    0x31:
      id: 'start'
      doc: 'Control message (communication control).'
    0x32:
      id: 'end'
      doc: 'Control message (communication control).'
    0x20:
      id: 'not_applicable'
      doc: 'Control message (health check control).'
  separation_of_tag:
    19:
      id: 'separation_between_tag'
      doc: 'DC3, 0x13, another tag follows'
    17:
      id: 'end_of_message'
      doc: 'DC1, 0x11, this tag ends the message'

