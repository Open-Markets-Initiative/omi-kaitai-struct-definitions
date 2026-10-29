# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx TseEquities IssueBasicInformation Flex v19.5
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: IssueBasicInformation
#   Encoding: Flex
#   Version: 19.5
#   Date: 09/25/2026
#   Specification: 05_FLEX Connection Specification Issue Basic Information DS.19.5.pdf
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
  id: jpx_tseequities_issuebasicinformation_flex_v19_5
  title: Jpx TseEquities IssueBasicInformation Flex v19.5
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Tokyo Stock Exchange Equities IssueBasicInformation Flex v19.5'

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
            '"II"': issue_information_message
            '"BP"': base_price_information_message
            '"MG"': multicast_group_number_information_message
            '"LC"': control_message
      - id: separation_of_tag
        type: u1
        enum: separation_of_tag
        doc: 'Control Code DC3 (0x13) between tags, or DC1 (0x11) on the tag that ends the message'
  issue_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: serial_no
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the applicable serial number, which will be allocated in sequence from the first to the last issues'
      - id: applicable_business_day
        type: yyyymmdd_ascii_date
        doc: 'Indicates the business day which the issue information applies'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: issue_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the issue name. (Chinese characters) The S-JIS code will be used'
      - id: security_type_etc_identification_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the security type, etc., code'
      - id: isin_flag
        type: u1
        enum: isin_flag
        doc: 'Indicates the ISIN flag'
      - id: new_security_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the New security code that is defined by the Securities Identification code committee'
      - id: industry_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Industry code'
      - id: new_listing_flag
        type: u1
        enum: new_listing_flag
        doc: 'Indicates the New listing flag'
      - id: when_issued_transaction_flag
        type: u1
        enum: when_issued_transaction_flag
        doc: 'Indicates the When-issued transaction issue'
      - id: short_selling_price_restriction_applied_flag_at_the_regular_distribution
        type: u1
        enum: short_selling_price_restriction_applied_flag_at_the_regular_distribution
        doc: 'Indicates the issue that applied the Short Selling Price Restriction at the regular distribution on the applicable business day'
      - id: loan_margin_flag
        type: u1
        enum: loan_margin_flag
        doc: 'Indicates the Loan・margin flag'
      - id: ex_dividend_ex_right_flag
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Ex-dividend / Ex-right flag'
      - id: securities_to_be_delisted_under_supervision_classification
        type: u1
        enum: securities_to_be_delisted_under_supervision_classification
        doc: 'Indicates the Securities to be delisted / under supervision classification'
      - id: reserved_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: unit_of_trading
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates unit of trading'
      - id: index_constituent_issue
        type: index_constituent_issue
        doc: 'Index constituent issue'
      - id: order_prohibition_status_at_the_regular_distribution
        type: order_prohibition_status_at_the_regular_distribution
        doc: 'Order Prohibition Status (at the regular distribution)'
      - id: reserved_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item will be reserved'
  index_constituent_issue:
    seq:
      - id: arbitrary_1
        type: u1
        enum: arbitrary_1
        doc: 'Indicates whether this is a constituent issue of TOPIX Core30'
      - id: arbitrary_2
        type: u1
        enum: arbitrary_2
        doc: 'Indicates whether this is a constituent issue of TOPIX Large70'
      - id: arbitrary_3
        type: u1
        enum: arbitrary_3
        doc: 'Indicates whether this is a constituent issue of TOPIX 100'
      - id: arbitrary_4
        type: u1
        enum: arbitrary_4
        doc: 'Indicates whether this is a constituent issue of Mid400'
      - id: arbitrary_5
        type: u1
        enum: arbitrary_5
        doc: 'Indicates whether this is a constituent issue of TOPIX 500'
      - id: arbitrary_6
        type: u1
        enum: arbitrary_6
        doc: 'Indicates whether this is a constituent issue of TOPIX Small'
      - id: arbitrary_7
        type: u1
        enum: arbitrary_7
        doc: 'Indicates whether this is a constituent issue of TOPIX 1000'
      - id: arbitrary_8_to_10
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unused. Space is set'
      - id: arbitrary_11
        type: u1
        enum: arbitrary_11
        doc: 'Indicates whether this is a constituent issue of TSE Growth Market 250 Index'
      - id: arbitrary_12_to_15
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unused. Space is set'
      - id: arbitrary_16
        type: u1
        enum: arbitrary_16
        doc: 'Indicates whether this is a constituent issue of REIT, general'
      - id: arbitrary_17_to_19
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unused. Space is set'
      - id: arbitrary_20
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unused. Space is set'
  order_prohibition_status_at_the_regular_distribution:
    seq:
      - id: new_orders_prohibition
        type: new_orders_prohibition
        doc: 'New Orders Prohibition'
      - id: margin_transactions_prohibition
        type: margin_transactions_prohibition
        doc: 'Margin Transactions Prohibition'
      - id: short_selling_prohibition
        type: short_selling_prohibition
        doc: 'Short Selling Prohibition'
      - id: all_orders_prohibition
        type: u1
        enum: all_orders_prohibition
        doc: 'Indicates the prohibition status for all orders including modification and cancel orders'
  new_orders_prohibition:
    seq:
      - id: market_limit_orders
        type: u1
        enum: market_limit_orders
        doc: 'Indicates the prohibited ordering for the order price of a new order'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the prohibited ordering for the side of a new order'
      - id: proprietary_brokerage
        type: u1
        enum: proprietary_brokerage
        doc: 'Indicates the prohibited ordering for the proprietary / brokerage classification of a new order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  margin_transactions_prohibition:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the prohibited ordering for the side of a new order'
      - id: proprietary_brokerage
        type: u1
        enum: proprietary_brokerage
        doc: 'Indicates the prohibited ordering for the proprietary / brokerage classification of a new order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  short_selling_prohibition:
    seq:
      - id: proprietary_brokerage
        type: u1
        enum: proprietary_brokerage
        doc: 'Indicates the prohibited ordering for the proprietary / brokerage classification of a new order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  base_price_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: based_business_day
        type: yyyymmdd_ascii_date
        doc: 'Indicates the applicable business day'
      - id: base_price
        type: base_price
        doc: 'Base Price'
      - id: limit_price_maximum
        type: limit_price_maximum
        doc: 'Limit Price (Maximum)'
      - id: limit_price_minimum
        type: limit_price_minimum
        doc: 'Limit Price (Minimum)'
      - id: base_price_price_of_the_middle_of_the_book
        type: u1
        enum: base_price_price_of_the_middle_of_the_book
        doc: 'Indicates the Base Price/Price of the Middle of the Book'
      - id: number_of_tick_size_table
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Number of Tick Size Table'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: reserved_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
  base_price:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates the Unit Flag'
      - id: price
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Base Price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the Sign of the Base Price'
  limit_price_maximum:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates the Unit Flag'
      - id: price
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Base Price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the Sign of the Base Price'
  limit_price_minimum:
    seq:
      - id: unit_flag
        type: u1
        enum: unit_flag
        doc: 'Indicates the Unit Flag'
      - id: price
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Base Price. Implied decimal with scale 1e-4'
      - id: sign
        type: u1
        enum: sign
        doc: 'Indicates the Sign of the Base Price'
  multicast_group_number_information_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
      - id: applicable_business_day
        type: yyyymmdd_ascii_date
        doc: 'Indicates the business day which the issue information applies'
      - id: issue_multicast_group_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Multicast Group Number for issues'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This item is reserved'
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
        doc: 'Indicates the flag for identifying the distinction between Real and Test Operation'
      - id: start_end_flag
        type: u1
        enum: start_end_flag
        doc: 'Indicates the flag for identifying the distinction between Start and End'
      - id: time
        type: hhmm_ascii_time
        doc: 'Indicates the time'
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
  isin_flag:
    0x31:
      id: 'identifiable_by_the_international_standard_code'
      doc: 'Identifiable By The International Standard Code'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  new_listing_flag:
    0x31:
      id: 'newly_listed_issue'
      doc: 'Newly Listed Issue'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  when_issued_transaction_flag:
    0x31:
      id: 'when_issued_transaction_issue'
      doc: 'When Issued Transaction Issue'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  short_selling_price_restriction_applied_flag_at_the_regular_distribution:
    0x31:
      id: 'the_issue_that_short_selling_regulation_is_applied'
      doc: 'The Issue That Short Selling Regulation Is Applied'
    0x20:
      id: 'other_than_the_above'
      doc: 'The issue that Short Selling Regulation is NOT applied.'
  loan_margin_flag:
    0x31:
      id: 'loan_issue'
      doc: 'Loan Issue'
    0x32:
      id: 'margin_transaction_issue'
      doc: 'Margin Transaction Issue'
    0x30:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  securities_to_be_delisted_under_supervision_classification:
    0x31:
      id: 'under_supervision_presently_under_examination'
      doc: 'Under Supervision Presently Under Examination'
    0x32:
      id: 'under_supervision_presently_under_confirmation'
      doc: 'Under Supervision Presently Under Confirmation'
    0x33:
      id: 'under_supervision_presently_under_examination_and_confirmation'
      doc: 'Under Supervision Presently Under Examination And Confirmation'
    0x34:
      id: 'under_supervision_presently_under_examination_and_on_special_alert'
      doc: 'Under Supervision Presently Under Examination And On Special Alert'
    0x35:
      id: 'under_supervision_presently_under_confirmation_and_on_special_alert'
      doc: 'Under Supervision Presently Under Confirmation And On Special Alert'
    0x36:
      id: 'under_supervision_presently_under_examination_and_confirmation_and_on_special_alert'
      doc: 'Under Supervision Presently Under Examination And Confirmation And On Special Alert'
    0x37:
      id: 'to_be_delisted'
      doc: 'To Be Delisted'
    0x38:
      id: 'to_be_delisted_and_on_special_alert'
      doc: 'To Be Delisted And On Special Alert'
    0x39:
      id: 'on_special_alert'
      doc: 'On Special Alert'
    0x30:
      id: 'none_specified'
      doc: 'None Specified'
  arbitrary_1:
    0x31:
      id: 'constituent_issue_of_topix_core_30'
      doc: 'Constituent Issue Of Topix Core 30'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_2:
    0x31:
      id: 'constituent_issue_of_topix_large_70'
      doc: 'Constituent Issue Of Topix Large 70'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_3:
    0x31:
      id: 'constituent_issue_of_topix_100'
      doc: 'Constituent Issue Of Topix 100'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_4:
    0x31:
      id: 'constituent_issue_of_mid_400'
      doc: 'Constituent Issue Of Mid 400'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_5:
    0x31:
      id: 'constituent_issue_of_topix_500'
      doc: 'Constituent Issue Of Topix 500'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_6:
    0x31:
      id: 'constituent_issue_of_topix_small'
      doc: 'Constituent Issue Of Topix Small'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_7:
    0x31:
      id: 'constituent_issue_of_topix_1000'
      doc: 'Constituent Issue Of Topix 1000'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_11:
    0x31:
      id: 'constituent_issue_of_tse_growth_market_250_index'
      doc: 'Constituent Issue Of Tse Growth Market 250 Index'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  arbitrary_16:
    0x31:
      id: 'constituent_issue_of_reit_general'
      doc: 'Constituent Issue Of Reit General'
    0x20:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  market_limit_orders:
    0x31:
      id: 'only_market_order_is_prohibited'
      doc: 'Only Market Order Is Prohibited'
    0x32:
      id: 'both_market_and_limit_orders_are_prohibited'
      doc: 'Both Market And Limit Orders Are Prohibited'
    0x20:
      id: 'other_than_the_above'
      doc: 'Nothing is prohibited for this type of order.'
  side:
    0x31:
      id: 'both_sell_and_buy_orders_are_prohibited'
      doc: 'Both Sell And Buy Orders Are Prohibited'
    0x32:
      id: 'only_sell_order_is_prohibited'
      doc: 'Only Sell Order Is Prohibited'
    0x33:
      id: 'only_buy_order_is_prohibited'
      doc: 'Only Buy Order Is Prohibited'
    0x20:
      id: 'other_than_the_above'
      doc: 'Nothing is prohibited for this type of order.'
  proprietary_brokerage:
    0x31:
      id: 'only_proprietary_order_is_prohibited'
      doc: 'Only Proprietary Order Is Prohibited'
    0x32:
      id: 'both_proprietary_and_brokerage_orders_are_prohibited'
      doc: 'Both Proprietary And Brokerage Orders Are Prohibited'
    0x20:
      id: 'other_than_the_above'
      doc: 'Nothing is prohibited for this type of order.'
  all_orders_prohibition:
    0x31:
      id: 'prohibited_for_all_orders'
      doc: 'Prohibited For All Orders'
    0x20:
      id: 'other_than_the_above'
      doc: 'Nothing is prohibited for this type of order.'
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
      doc: 'Set on a price.'
    0x20:
      id: 'no_sign'
      doc: 'When the numerical part is all-space, the sign will be space.'
  base_price_price_of_the_middle_of_the_book:
    0x31:
      id: 'base_price'
      doc: 'Base Price'
    0x32:
      id: 'price_of_the_middle_of_the_book'
      doc: 'Price Of The Middle Of The Book'
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
      doc: 'Control Message other than Health Check Control.'
    0x32:
      id: 'end'
      doc: 'Control Message other than Health Check Control.'
    0x20:
      id: 'not_applicable'
      doc: 'Control Message (Health Check Control).'
  separation_of_tag:
    19:
      id: 'separation_between_tag'
      doc: 'DC3, 0x13, another tag follows'
    17:
      id: 'end_of_message'
      doc: 'DC1, 0x11, this tag ends the message'

