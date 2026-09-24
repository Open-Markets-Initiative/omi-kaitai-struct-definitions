# ---------------------------------------------------------------------
# Kaitai struct definition for: Finra FinraOrf Tdds Dfi v2.1
#
# Protocol:
#   Organization: Financial Industry Regulatory Authority
#   Protocol: Trade Data Dissemination Service
#   Encoding: Data Feed Interface
#   Version: 2.1
#   Date: 5/10/2022
#   Specification: TDDS-2.1-MOLD.pdf
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
  id: finra_finraorf_tdds_dfi_v2_1
  title: Finra FinraOrf Tdds Dfi v2.1
  license: GPL-3.0
  endian: be

doc: 'Financial Industry Regulatory Authority Finra ORF Trade Data Dissemination Service Dfi v2.1'
doc-ref: https://www.finra.org/filing-reporting/orf/orf-forms-and-documentation

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.count

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session the payload relates to'
      - id: sequence
        type: u8
        doc: 'Sequence Number of the first message to follow this header'
      - id: count
        type: u2
        doc: 'Number of messages to follow this header'
  message_struct:
    seq:
      - id: mold_udp64
        type: mold_udp64
        doc: 'Mold Udp64 Dfi Message Header'
      - id: payload
        size: mold_udp64.length - 1
        type:
          switch-on: mold_udp64.message_category
          cases:
            'message_category::trade': trade_message
            'message_category::administrative': administrative_message
            'message_category::control': control_message
  mold_udp64:
    seq:
      - id: length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Message Category'
  trade_message:
    seq:
      - id: trade_message_type
        type: u1
        enum: trade_message_type
        doc: 'Trade message type'
      - id: trade_message_payload
        type:
          switch-on: trade_message_type
          cases:
            'trade_message_type::trade_report_short_form_message': trade_report_short_form_message
            'trade_message_type::trade_report_long_form_message': trade_report_long_form_message
            'trade_message_type::trade_cancel_error_message': trade_cancel_error_message
            'trade_message_type::trade_correction_message': trade_correction_message
  trade_report_short_form_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: sale_condition_level_1
        type: u1
        enum: sale_condition_level_1
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: trade_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes the whole dollar and decimal digit composition for the Trade Price field'
      - id: trade_price_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'This field indicates the trade price for the current transaction'
      - id: report_volume_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'This field denotes the number of shares reported in the current Trade Report'
      - id: price_change_indicator
        type: u1
        enum: price_change_indicator
        doc: 'The Price Change Indicator field indicates if the high, low, and/or last sale prices were impacted by the current trade transaction'
  message_header:
    seq:
      - id: trade_identifier
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'An identifier for tracking trades'
      - id: market_center_originator_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the market center or system that originated the message that follows'
      - id: datetime
        type: datetime
        doc: 'Datetime'
  datetime:
    seq:
      - id: year
        type: str
        size: 4
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: str
        size: 2
        encoding: ASCII
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: str
        size: 2
        encoding: ASCII
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: str
        size: 2
        encoding: ASCII
        doc: 'The second of the minute the transaction occurred'
      - id: fractional_second
        type: str
        size: 9
        encoding: ASCII
        doc: 'The smallest unit of seconds, up to nanoseconds, the transaction occurred'
  trade_report_long_form_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: trade_information
        type: trade_information
        doc: 'Trade Information'
  original_dissemination_date:
    seq:
      - id: year
        type: str
        size: 4
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        doc: 'The day of the month the transaction occurred'
  trade_information:
    seq:
      - id: report_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'This field denotes the number of shares reported in the current Trade Report'
      - id: trade_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes the whole dollar and decimal digit composition for the Trade Price field'
      - id: trade_price
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the trade price for the current transaction'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the currency in which the trade transaction was reported'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'This field will be populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: sale_condition_level_1
        type: u1
        enum: sale_condition_level_1
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is reserved and may be used in the future'
      - id: sale_condition_level_3
        type: u1
        enum: sale_condition_level_3
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_4
        type: u1
        enum: sale_condition_level_4
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sellers_sale_days
        type: str
        size: 2
        encoding: ASCII
        doc: 'this field will reflect the number of days that may elapse before delivery of the stock'
      - id: price_change_indicator
        type: u1
        enum: price_change_indicator
        doc: 'The Price Change Indicator field indicates if the high, low, and/or last sale prices were impacted by the current trade transaction'
  execution_datetime:
    seq:
      - id: year
        type: str
        size: 4
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: str
        size: 2
        encoding: ASCII
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: str
        size: 2
        encoding: ASCII
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: str
        size: 2
        encoding: ASCII
        doc: 'The second of the minute the transaction occurred'
      - id: fractional_second
        type: str
        size: 9
        encoding: ASCII
        doc: 'The smallest unit of seconds, up to nanoseconds, the transaction occurred'
  trade_cancel_error_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: report_function
        type: u1
        enum: report_function
        doc: 'This Function field denotes if the original trade report is being cancelled or was reported in error'
      - id: original_trade_information
        type: original_trade_information
        doc: 'Original Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  original_trade_information:
    seq:
      - id: report_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'This field denotes the number of shares reported in the current Trade Report'
      - id: trade_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes the whole dollar and decimal digit composition for the Trade Price field'
      - id: trade_price
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the trade price for the current transaction'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the currency in which the trade transaction was reported'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'This field will be populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: sale_condition_level_1
        type: u1
        enum: sale_condition_level_1
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is reserved and may be used in the future'
      - id: sale_condition_level_3
        type: u1
        enum: sale_condition_level_3
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_4
        type: u1
        enum: sale_condition_level_4
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sellers_sale_days
        type: str
        size: 2
        encoding: ASCII
        doc: 'this field will reflect the number of days that may elapse before delivery of the stock'
  trade_summary_information:
    seq:
      - id: high_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The High Price Denominator indicates the whole dollar and decimal digit composition of the High Price field'
      - id: high_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The High Price field indicates the highest price at which the security traded up to the current point in the trading session'
      - id: low_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Low Price Denominator field indicates the whole dollar and decimal digit composition of the Low Price field'
      - id: low_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The Low Price field indicates the lowest price at which the security traded up to the current point in the trading session'
      - id: last_sale_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Last Sale Price Denominator field indicates the whole dollar and decimal digit composition of the Last Sale Price field'
      - id: last_sale_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Last Sale Price field indicates the current last sale price for the given security'
      - id: last_sale_price_market_center
        type: u1
        enum: last_sale_price_market_center
        doc: 'This field indicates the market center responsible for the closing price'
      - id: total_security_volume
        type: str
        size: 11
        encoding: ASCII
        doc: 'This field reflects the total number of shares traded during the session for the given security'
      - id: price_change_indicator
        type: u1
        enum: price_change_indicator
        doc: 'The Price Change Indicator field indicates if the high, low, and/or last sale prices were impacted by the current trade transaction'
  trade_correction_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: report_function
        type: u1
        enum: report_function
        doc: 'This Function field denotes if the original trade report is being cancelled or was reported in error'
      - id: original_trade_information
        type: original_trade_information
        doc: 'Original Trade Information'
      - id: corrected_trade_information
        type: corrected_trade_information
        doc: 'Corrected Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  corrected_trade_information:
    seq:
      - id: report_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'This field denotes the number of shares reported in the current Trade Report'
      - id: trade_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes the whole dollar and decimal digit composition for the Trade Price field'
      - id: trade_price
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the trade price for the current transaction'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the currency in which the trade transaction was reported'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'This field will be populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: sale_condition_level_1
        type: u1
        enum: sale_condition_level_1
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is reserved and may be used in the future'
      - id: sale_condition_level_3
        type: u1
        enum: sale_condition_level_3
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sale_condition_level_4
        type: u1
        enum: sale_condition_level_4
        doc: 'This field is used to denote the sale condition associated with a trade transaction'
      - id: sellers_sale_days
        type: str
        size: 2
        encoding: ASCII
        doc: 'this field will reflect the number of days that may elapse before delivery of the stock'
  administrative_message:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::general_administrative_message': general_administrative_message
            'administrative_message_type::closing_trade_summary_report_message': closing_trade_summary_report_message
            'administrative_message_type::trading_action_message': trading_action_message
            'administrative_message_type::market_wide_circuit_breaker_event_message': market_wide_circuit_breaker_event_message
  general_administrative_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: text
        type: str
        size: _parent._parent.mold_udp64.length - 35
        encoding: ASCII
  closing_trade_summary_report_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: daily_high_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Closing Price Denominator field indicates the whole dollar and decimal digit composition of the Closing Price field'
      - id: daily_high_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Daily High Price field indicates the highest price at which the security traded during the session'
      - id: daily_low_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Closing Price Denominator field indicates the whole dollar and decimal digit composition of the Closing Price field'
      - id: daily_low_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Daily High Price field indicates the lowest price at which the security traded during the session'
      - id: closing_price_market_center
        type: u1
        enum: closing_price_market_center
        doc: 'This field indicates the market center responsible for the closing price'
      - id: closing_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Closing Price Denominator field indicates the whole dollar and decimal digit composition of the Closing Price field'
      - id: closing_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Closing Price field reflects the final last sale eligible transaction reported to ORF for the security during the current business day'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field will be space filled'
      - id: net_change_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Net Change Denominator indicates the whole dollar and decimal digit composition of the Net Change Amount field'
      - id: net_change_amount
        type: str
        size: 10
        encoding: ASCII
        doc: 'The Net Change Amount field reflects the absolute value of the difference between the current closing price and the adjusted previous day’s closing price'
      - id: net_change_direction
        type: u1
        enum: net_change_direction
        doc: 'This field indicates the direction of net change field'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the currency in which the trade transaction was reported'
      - id: total_security_volume
        type: str
        size: 11
        encoding: ASCII
        doc: 'This field reflects the total number of shares traded during the session for the given security'
  trading_action_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: security_symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This Security Symbol field indicates the security identifier assigned by FINRA for a given security'
      - id: action
        type: u1
        enum: action
        doc: 'used to relate the status of the individual security or marketplace'
      - id: action_datetime
        type: action_datetime
        doc: 'Action Datetime'
      - id: trading_action_reason_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Reason Code indicates the reason for the current trading action status'
  action_datetime:
    seq:
      - id: year
        type: str
        size: 4
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: str
        size: 2
        encoding: ASCII
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: str
        size: 2
        encoding: ASCII
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: str
        size: 2
        encoding: ASCII
        doc: 'The second of the minute the transaction occurred'
      - id: fractional_second
        type: str
        size: 9
        encoding: ASCII
        doc: 'The smallest unit of seconds, up to nanoseconds, the transaction occurred'
  market_wide_circuit_breaker_event_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: action
        type: u1
        enum: action
        doc: 'used to relate the status of the individual security or marketplace'
      - id: action_datetime
        type: action_datetime
        doc: 'Action Datetime'
      - id: market_wide_circuit_breaker_reason_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Reason Code indicates the reason for the current trading action status'
  control_message:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Control message type'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day_message': start_of_day_message
            'control_message_type::end_of_day_message': end_of_day_message
            'control_message_type::market_session_open_message': market_session_open_message
            'control_message_type::market_session_close_message': market_session_close_message
            'control_message_type::end_of_retransmission_requests_message': end_of_retransmission_requests_message
            'control_message_type::end_of_transmissions_message': end_of_transmissions_message
            'control_message_type::line_integrity_message': line_integrity_message
            'control_message_type::sequence_number_reset_message': sequence_number_reset_message
            'control_message_type::end_of_trade_reporting_message': end_of_trade_reporting_message
  start_of_day_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  end_of_day_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  market_session_open_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  market_session_close_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  end_of_retransmission_requests_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  end_of_transmissions_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  line_integrity_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  sequence_number_reset_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  end_of_trade_reporting_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'

enums:
  message_category:
    0x54:
      id: 'trade'
      doc: 'Trade Messages Header'
    0x41:
      id: 'administrative'
      doc: 'Administrative Messages Header'
    0x43:
      id: 'control'
      doc: 'Control Messages Header'
  trade_message_type:
    0x35:
      id: 'trade_report_short_form_message'
      doc: 'Economized trade report'
    0x36:
      id: 'trade_report_long_form_message'
      doc: 'Complete trade report'
    0x37:
      id: 'trade_cancel_error_message'
      doc: 'This message is used to notify TDDS customers if a trade report entered during the current business day, or up to the past three business days, has been canceled'
    0x38:
      id: 'trade_correction_message'
      doc: 'Used to notify TDDS customers if a trade report entered during the current business day, or up to the past three business days, has been modified'
  sale_condition_level_1:
    0x40:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x43:
      id: 'cash_trade'
      doc: 'Cash Trade'
    0x4e:
      id: 'next_day'
      doc: 'Next Day'
    0x52:
      id: 'seller'
      doc: 'Seller'
  price_change_indicator:
    0x30:
      id: 'no_price_change'
      doc: 'No Price Change'
    0x31:
      id: 'last_price_changed'
      doc: 'Last Price Changed'
    0x32:
      id: 'low_price_changed'
      doc: 'Low Price Changed'
    0x33:
      id: 'last_and_low_prices_changed'
      doc: 'Last And Low Prices Changed'
    0x34:
      id: 'high_price_changed'
      doc: 'High Price Changed'
    0x35:
      id: 'last_and_high_prices_changed'
      doc: 'Last And High Prices Changed'
    0x36:
      id: 'high_and_low_prices_changed'
      doc: 'High And Low Prices Changed'
    0x37:
      id: 'all_prices_changed'
      doc: 'All Prices Changed'
  as_of_indicator:
    0x41:
      id: 'as_of'
      doc: 'As Of'
    0x52:
      id: 'reversal'
      doc: 'Reversal'
    0x20:
      id: 'current_day_transaction'
      doc: 'Current Day Transaction'
  sale_condition_level_3:
    0x54:
      id: 'executed_outside_normal_market_hours'
      doc: 'Executed Outside Normal Market Hours'
    0x55:
      id: 'executed_outside_normal_market_hours_and_trade_reported_late'
      doc: 'Executed Outside Normal Market Hours And Trade Reported Late'
    0x5a:
      id: 'executed_during_normal_market_hours_and_trade_reported_late'
      doc: 'Executed During Normal Market Hours And Trade Reported Late'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  sale_condition_level_4:
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  report_function:
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x45:
      id: 'error'
      doc: 'Error'
    0x4e:
      id: 'correction'
      doc: 'Correction'
  last_sale_price_market_center:
    0x75:
      id: 'ootc'
      doc: 'Ootc'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  administrative_message_type:
    0x41:
      id: 'general_administrative_message'
      doc: 'A variable length, free-form text message format will be used on an as-needed basis'
    0x32:
      id: 'closing_trade_summary_report_message'
      doc: 'The closing trade summary will reflect the daily high, low, and closing prices as well as the total volume for the security'
    0x48:
      id: 'trading_action_message'
      doc: 'FINRA will disseminate this message to inform customers of trading actions, such as halts or trading resumptions which affect individual OTCBB or Other OTC securities'
    0x4d:
      id: 'market_wide_circuit_breaker_event_message'
      doc: 'FINRA will disseminate this message to inform customers of an extraordinary market event trading action or a market wide circuit breaker event which will affect all security symbols for either OTCBB, Other OTC or both OTCBB and Other OTC market places'
  closing_price_market_center:
    0x75:
      id: 'ootc'
      doc: 'Ootc'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  net_change_direction:
    0x2b:
      id: 'positive_or_zero_net_change'
      doc: 'Positive Or Zero Net Change'
    0x2d:
      id: 'negative_net_change'
      doc: 'Negative Net Change'
    0x20:
      id: 'no_trade_or_unaffected'
      doc: 'No Trade Or Unaffected'
  action:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption'
      doc: 'Quotation Resumption'
    0x54:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
    0x58:
      id: 'quotation_and_trading_resumption'
      doc: 'Quotation And Trading Resumption'
  control_message_type:
    0x49:
      id: 'start_of_day_message'
      doc: 'The Start of Day control message signifies the beginning of each operational cycle for TDDS processing'
    0x4a:
      id: 'end_of_day_message'
      doc: 'The End of Day control message signals the end of active message dissemination for the TDDS operational cycle'
    0x4f:
      id: 'market_session_open_message'
      doc: 'The Market Session Open Control Message signifies the opening of FINRA’s market systems for the session indicated in the Message Header'
    0x43:
      id: 'market_session_close_message'
      doc: 'The Session Close Control Message signals the closing of FINRA’s market systems for the session indicated in the Message Header'
    0x4b:
      id: 'end_of_retransmission_requests_message'
      doc: 'This message signals that no further retransmission requests will be honored. The End of Retransmission Requests message will be sent three times, at one-minute intervals'
    0x5a:
      id: 'end_of_transmissions_message'
      doc: 'The End of Transmissions Message signals that there will be no further transmissions of data sent through the TDDS line.'
    0x54:
      id: 'line_integrity_message'
      doc: 'The Line Integrity Control Message will be transmitted at approximately one-minute intervals to verify the operational integrity of the TDDS message transmission, and will be intermixed with other messages'
    0x4c:
      id: 'sequence_number_reset_message'
      doc: 'The Sequence Number Reset Message forces the resetting of the Sequence Number. The Sequence Number will either be reset to zero or to a number greater than the last number previously transmitted'
    0x58:
      id: 'end_of_trade_reporting_message'
      doc: 'The End of Trade Reporting Control Message signals that the ORF system is closed for market participant trade transactions'

