# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx SseEquities Standard Flex v19.5
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Standard
#   Encoding: Flex
#   Version: 19.5
#   Date: 09/25/2026
#   Specification: 02_FLEX Connection Specification Realtime Message (Standard) DS.19.3.pdf
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
  id: jpx_sseequities_standard_flex_v19_5
  title: Jpx SseEquities Standard Flex v19.5
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Sapporo Securities Exchange Equities Standard Flex v19.5'

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
            '"NO"': update_no_message
            '"ST"': status_information_message
            '"4P"': open_high_low_and_current_price_message
            '"Q1"': quote_1_message
            '"Q2"': quote_2_message
            '"Q3"': quote_3_message
            '"Q4"': quote_4_message
            '"Q5"': quote_5_message
            '"Q6"': quote_6_message
            '"Q7"': quote_7_message
            '"Q8"': quote_8_message
            '"Q9"': quote_9_message
            '"QA"': quote_10_message
            '"QM"': market_order_message
            '"QO"': over_under_message
            '"VL"': trading_volume_message
            '"VA"': turnover_message
            '"VW"': vwap_message
            '"PA"': parity_message
            '"YI"': yield_message
            '"LC"': control_message
      - id: separation_of_tag
        type: u1
        enum: separation_of_tag
        doc: 'Control Code DC3 (0x13) between tags, or DC1 (0x11) on the tag that ends the message'
  update_no_message:
    seq:
      - id: update_no
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the update number. Larger update number indicates newer data'
  status_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: status_information
        type: status_information
        doc: 'Status Information'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: reserved_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  status_information:
    seq:
      - id: issue_status
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates issue status'
      - id: status_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the status of the trade'
      - id: short_selling_regulation_flag
        type: u1
        enum: short_selling_regulation_flag
        doc: 'Indicates whether short selling regulation applies or not'
  open_high_low_and_current_price_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: open
        type: open
        doc: 'Open'
      - id: high
        type: high
        doc: 'High'
      - id: low
        type: low
        doc: 'Low'
      - id: current
        type: current
        doc: 'Current'
  open:
    seq:
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
  price:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'A numerical value from 0 to 4 indicating the number of decimal places that are set to zero'
      - id: price_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Numerical part: a 10 digit integral part and a 4 digit decimal part. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
  high:
    seq:
      - id: limit_up_flag
        type: u1
        enum: limit_up_flag
        doc: 'Indicates limit up'
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
  low:
    seq:
      - id: limit_down_flag
        type: u1
        enum: limit_down_flag
        doc: 'Indicates limit down'
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
  current:
    seq:
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: current_change_flag
        type: u1
        enum: current_change_flag
        doc: 'Indicates whether this has changed or not'
      - id: stq_reference_point_flag
        type: u1
        enum: stq_reference_point_flag
        doc: 'Indicates the reference execution for Sequential Trade Quote'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: closing_price_input_flag
        type: u1
        enum: closing_price_input_flag
        doc: 'Indicates whether a closing price was reached'
  quote_1_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  ask_quote:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_flag
        type: u1
        enum: quote_flag
        doc: 'Indicates the type of the quote'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  quote_quantity:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'The unit of the numerical value to be set in the integral part'
      - id: quantity
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Numerical part: the 14 digits of an integer'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
  bid_quote:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: price
        type: price
        doc: 'Price'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_flag
        type: u1
        enum: quote_flag
        doc: 'Indicates the type of the quote'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  quote_2_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_3_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_4_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_5_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_6_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_7_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_8_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_9_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  quote_10_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: ask_quote
        type: ask_quote
        doc: 'Ask Quote'
      - id: bid_quote
        type: bid_quote
        doc: 'Bid Quote'
  market_order_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: sell_order
        type: sell_order
        doc: 'Sell Order'
      - id: buy_order
        type: buy_order
        doc: 'Buy Order'
  sell_order:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  buy_order:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  over_under_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: over_quote
        type: over_quote
        doc: 'OVER Quote'
      - id: under_quote
        type: under_quote
        doc: 'UNDER Quote'
  over_quote:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  under_quote:
    seq:
      - id: change_flag
        type: u1
        enum: change_flag
        doc: 'For issue status, status flag or short selling regulation flag, indicates whether this has changed or not'
      - id: time_c_12
        type: hhmmssuuuuuu_ascii_time
        doc: 'Indicates the changed time of Status Change Information'
      - id: quote_quantity
        type: quote_quantity
        doc: 'Quote Quantity'
  trading_volume_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: trading_volume
        type: trading_volume
        doc: 'Trading Volume'
  trading_volume:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'The unit of the numerical value to be set in the integral part'
      - id: trading_volume_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item shows the cumulative Trading Volume for the morning and afternoon sessions'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  turnover_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: turnover_in_yen_value
        type: turnover_in_yen_value
        doc: 'Turnover in yen value'
  turnover_in_yen_value:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'The unit of the numerical value to be set in the integral part'
      - id: turnover_value
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item shows the cumulative turnover for the morning and afternoon sessions'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  vwap_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: all_day_vwap
        type: all_day_vwap
        doc: 'All-Day VWAP'
      - id: current_session_vwap
        type: current_session_vwap
        doc: 'Current-Session VWAP'
  all_day_vwap:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: lot_size_unit_flag
        type: u1
        enum: lot_size_unit_flag
        doc: 'Indicates the lot size unit flag'
      - id: all_day_vwap_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the All-Day VWAP. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  current_session_vwap:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: lot_size_unit_flag
        type: u1
        enum: lot_size_unit_flag
        doc: 'Indicates the lot size unit flag'
      - id: current_session_vwap_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Current-Session VWAP. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  parity_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: parity_estimated_price
        type: parity_estimated_price
        doc: 'Parity/Estimated Price'
  parity_estimated_price:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'A numerical value from 0 to 4 indicating the number of decimal places that are set to zero'
      - id: parity_estimated_price_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates Parity. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  yield_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: direct_yield
        type: direct_yield
        doc: 'Direct Yield'
      - id: final_yield
        type: final_yield
        doc: 'Final Yield'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  direct_yield:
    seq:
      - id: direct_yield_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Direct Yield. The unit is 1/100%. Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
  final_yield:
    seq:
      - id: final_yield_c_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the final yield. The unit is 1/1000%. Implied decimal with scale 1e-3'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates sign'
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
        doc: 'Indicates the flag for identifying the distinction between Production and Test Operation'
      - id: start_end_flag
        type: u1
        enum: start_end_flag
        doc: 'Indicates the flag for identifying the distinction between Start and End'
      - id: time_c_6
        type: hhmmss_ascii_time
        doc: 'Indicates the time at which the current price, Special Quote price or Sequential Trade Quote price of the relevant issue, which is subject to computation of Direct and Final yield, occurred or changed'
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
  hhmmssuuuuuu_ascii_time:
    seq:
      - id: text
        type: str
        size: 12
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
      microsecond:
        value: text.substring(6, 12).to_i
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
  change_flag:
    0x31:
      id: 'changed'
      doc: 'Changed'
    0x20:
      id: 'not_changed'
      doc: 'Space is set when this tag is sent as Backup Information or All-Day Information.'
  short_selling_regulation_flag:
    0x30:
      id: 'short_selling_regulation_does_not_apply'
      doc: 'Short Selling Regulation Does Not Apply'
    0x31:
      id: 'short_selling_regulation_is_applied'
      doc: 'Short Selling Regulation Is Applied'
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
  sign:
    0x2b:
      id: 'positive'
      doc: '“+” is set.'
    0x20:
      id: 'no_sign'
      doc: 'When the Numerical Part is all-space, the sign will be space.'
  limit_up_flag:
    0x31:
      id: 'limit_up'
      doc: 'Limit Up'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  limit_down_flag:
    0x31:
      id: 'limit_down'
      doc: 'Limit Down'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  current_change_flag:
    0x31:
      id: 'changed_going_up'
      doc: 'Execution Price is higher than last one.'
    0x32:
      id: 'changed_going_down'
      doc: 'Execution Price is lower than last one.'
    0x33:
      id: 'changed_same'
      doc: 'Execution Price is same as last one.'
    0x34:
      id: 'changed_other_than_above'
      doc: 'Execution with no last price or ZARABA Close.'
    0x20:
      id: 'other_than_the_above'
      doc: 'Space is set when this tag is sent as Backup Information or All-Day Information.'
  stq_reference_point_flag:
    0x31:
      id: 'reference_execution_set_by_this_trade'
      doc: 'When the reference execution of Sequential Trade Quote is set by this trade.'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  closing_price_input_flag:
    0x31:
      id: 'trade_not_established_at_closing'
      doc: 'When the trade isn’t established at closing (ZARABA Close).'
    0x32:
      id: 'trade_established_with_closing'
      doc: 'When the trade is established with closing (Close at the Closing Price).'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  quote_flag:
    0x30:
      id: 'quote_before_opening'
      doc: 'Quote 1 only.'
    0x31:
      id: 'general_quote'
      doc: 'General Quote'
    0x32:
      id: 'general_quote_under_transaction'
      doc: 'Quote 1 only. It is set when it keeps changing in Q1 by a single order under Zaraba session.'
    0x33:
      id: 'special_quote'
      doc: 'Quote 1 only.'
    0x34:
      id: 'sequential_trade_quote'
      doc: 'Quote 1 only.'
    0x35:
      id: 'temporary_quote_at_the_beginning_of_pre_closing'
      doc: 'Quote 1 only.'
    0x36:
      id: 'quote_after_special_execution'
      doc: 'Quote 1 only. It is set in case ask orders are executed by special execution method.'
    0x37:
      id: 'special_quote_before_trading_halt'
      doc: 'Quote 1 only. It is set when Trading Halt or Trading Suspension occurs while Special Quote is displayed.'
    0x38:
      id: 'sequential_trade_quote_before_trading_halt'
      doc: 'Quote 1 only. It is set when Trading Halt or Trading Suspension occurs while Sequential Trade Quote is displayed.'
    0x20:
      id: 'no_quotes_or_all_quotes_are_cancelled'
      doc: 'No Quotes Or All Quotes Are Cancelled'
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
  lot_size_unit_flag:
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
  test_mode_flag:
    0x31:
      id: 'production_operation'
      doc: 'Production Operation'
    0x32:
      id: 'test_operation'
      doc: 'Test Operation'
  start_end_flag:
    0x31:
      id: 'start'
      doc: 'Start'
    0x32:
      id: 'end'
      doc: 'End'
    0x20:
      id: 'health_check_control'
      doc: 'In the case of Control Message (Health Check Control): space.'
  separation_of_tag:
    19:
      id: 'separation_between_tag'
      doc: 'DC3, 0x13, another tag follows'
    17:
      id: 'end_of_message'
      doc: 'DC1, 0x11, this tag ends the message'

