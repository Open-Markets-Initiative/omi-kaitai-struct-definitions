# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx TseEquities ToSTNeT Flex v19.5
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: ToSTNeT
#   Encoding: Flex
#   Version: 19.5
#   Date: 09/25/2026
#   Specification: 04_FLEX Connection Specification ToSTNeT DS.19.0.pdf
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
  id: jpx_tseequities_tostnet_flex_v19_5
  title: Jpx TseEquities ToSTNeT Flex v19.5
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Tokyo Stock Exchange Equities ToSTNeT Flex v19.5'

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
            '"TI"': tostnet_byissue_information_message
            '"TM"': tostnet_market_information_message
            '"LC"': control_message
      - id: separation_of_tag
        type: u1
        enum: separation_of_tag
        doc: 'Control Code DC3 (0x13) between tags, or DC1 (0x11) on the tag that ends the message'
  tostnet_byissue_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: market_identification_flag
        type: u1
        enum: market_identification_flag
        doc: 'Indicates the flag for identifying ToSTNeT market'
      - id: trading_halt
        type: trading_halt
        doc: 'Trading Halt'
      - id: transaction_identification_flag
        type: u1
        enum: transaction_identification_flag
        doc: 'Indicates the identification of the transaction'
      - id: price
        type: price
        doc: 'Price'
      - id: trading_volume
        type: trading_volume
        doc: 'Trading Volume'
      - id: turnover
        type: turnover
        doc: 'Turnover'
  trading_halt:
    seq:
      - id: state_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the state of trading halt for the issue on the ToSTNeT'
      - id: time_c_6
        type: hhmm_ascii_time
        doc: 'Indicates time'
  price:
    seq:
      - id: price_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the price code for the transaction'
      - id: lot_size_unit_flag
        type: u1
        enum: lot_size_unit_flag
        doc: 'Indicates that this is the lot size unit flag'
      - id: price_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates that this is the trade price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates Sign of Price'
      - id: time_c_12
        type: hhmmssmm_ascii_time
        doc: 'Indicates the time at which the trade was established'
  trading_volume:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the trading volume/turnover unit flag'
      - id: trading_volume_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicatds the trading volume'
  turnover:
    seq:
      - id: trading_volume_turnover_unit_flag
        type: u1
        enum: trading_volume_turnover_unit_flag
        doc: 'Indicates the trading volume/turnover unit flag'
      - id: turnover_c_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indiactes the turnover'
  tostnet_market_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: market_identification_flag
        type: u1
        enum: market_identification_flag
        doc: 'Indicates the flag for identifying ToSTNeT market'
      - id: state
        type: state
        doc: 'State'
  state:
    seq:
      - id: market_state_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the state of trading halt for the issue on the ToSTNeT'
      - id: time_c_6
        type: hhmm_ascii_time
        doc: 'Indicates time'
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
      - id: start_end_flag
        type: u1
        enum: start_end_flag
        doc: 'Indicates the flag for identifying the distinction between start and end'
      - id: time_c_6
        type: hhmm_ascii_time
        doc: 'Indicates time'
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
  hhmmssmm_ascii_time:
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
      hundredth:
        value: text.substring(6, 8).to_i

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
  market_identification_flag:
    0x31:
      id: 'single_issue_transaction'
      doc: 'Single Issue Transaction'
    0x32:
      id: 'basket_transaction'
      doc: 'Basket Transaction'
    0x33:
      id: 'closing_price_transaction'
      doc: 'Closing Price Transaction'
  transaction_identification_flag:
    0x31:
      id: 'day_transaction'
      doc: 'Day Transaction'
    0x32:
      id: 'ordinary_transaction_t_2_vwap_transaction'
      doc: 'Ordinary Transaction T 2 Vwap Transaction'
    0x33:
      id: 'day_transaction_vwap_transaction'
      doc: 'Day Transaction Vwap Transaction'
    0x20:
      id: 'ordinary_transaction_t_2'
      doc: 'A space is also set for a closing price transaction, and for a trading halt and a release from trading halt.'
    0x41:
      id: 'ordinary_transaction_t_1'
      doc: 'Ordinary Transaction T 1'
    0x42:
      id: 'ordinary_transaction_t_1_vwap_transaction'
      doc: 'Ordinary Transaction T 1 Vwap Transaction'
    0x43:
      id: 'ordinary_transaction_t_3'
      doc: 'Ordinary Transaction T 3'
    0x44:
      id: 'ordinary_transaction_t_3_vwap_transaction'
      doc: 'Ordinary Transaction T 3 Vwap Transaction'
    0x45:
      id: 'ordinary_transaction_t_4'
      doc: 'Ordinary Transaction T 4'
    0x46:
      id: 'ordinary_transaction_t_4_vwap_transaction'
      doc: 'Ordinary Transaction T 4 Vwap Transaction'
    0x47:
      id: 'ordinary_transaction_t_5'
      doc: 'Ordinary Transaction T 5'
    0x48:
      id: 'ordinary_transaction_t_5_vwap_transaction'
      doc: 'Ordinary Transaction T 5 Vwap Transaction'
    0x49:
      id: 'ordinary_transaction_t_6'
      doc: 'Ordinary Transaction T 6'
    0x4a:
      id: 'ordinary_transaction_t_6_vwap_transaction'
      doc: 'Ordinary Transaction T 6 Vwap Transaction'
    0x4b:
      id: 'ordinary_transaction_t_7'
      doc: 'Ordinary Transaction T 7'
    0x4c:
      id: 'ordinary_transaction_t_7_vwap_transaction'
      doc: 'Ordinary Transaction T 7 Vwap Transaction'
    0x4d:
      id: 'ordinary_transaction_t_8'
      doc: 'Ordinary Transaction T 8'
    0x4e:
      id: 'ordinary_transaction_t_8_vwap_transaction'
      doc: 'Ordinary Transaction T 8 Vwap Transaction'
    0x4f:
      id: 'ordinary_transaction_t_9'
      doc: 'Ordinary Transaction T 9'
    0x50:
      id: 'ordinary_transaction_t_9_vwap_transaction'
      doc: 'Ordinary Transaction T 9 Vwap Transaction'
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
      doc: 'A space is set for a trading halt and a release from trading halt.'
  sign:
    0x2b:
      id: 'positive'
      doc: 'Set on a trade price.'
    0x20:
      id: 'no_sign'
      doc: 'A space is set for a trading halt and a release from trading halt.'
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
      doc: 'A space is set for a trading halt and a release from trading halt.'
  test_mode_flag:
    0x31:
      id: 'real_operation'
      doc: 'Real Operation'
    0x32:
      id: 'test_operation'
      doc: 'Test Operation'
  start_end_flag:
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

