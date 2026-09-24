# ---------------------------------------------------------------------
# Kaitai struct definition for: Finra Trace Btds144A Dfi v2.1
#
# Protocol:
#   Organization: Financial Industry Regulatory Authority
#   Protocol: Bond Trade Dissemination Service for 144A Transactions
#   Encoding: FINRA Data Feed Interface
#   Version: 2.1
#   Date: 3/21/2024
#   Specification: FINRA BTDS-144A Specification (MOLD 2.1).pdf
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
  id: finra_trace_btds144a_dfi_v2_1
  title: Finra Trace Btds144A Dfi v2.1
  license: GPL-3.0
  endian: be

doc: 'Financial Industry Regulatory Authority Finra TRACE Bond Trade Dissemination Service for 144A Transactions Dfi v2.1'
doc-ref: https://www.finra.org/filing-reporting/trace/documentation

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
            'trade_message_type::trade_report_message': trade_report_message
            'trade_message_type::trade_cancel_message': trade_cancel_message
            'trade_message_type::trade_correction_message': trade_correction_message
  trade_report_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: trade_information
        type: trade_information
        doc: 'Trade Information'
      - id: change_indicator
        type: u1
        enum: change_indicator
        doc: 'Describes the price change(s) that the transaction caused for the issue traded'
  message_header:
    seq:
      - id: trade_identifier
        type: str
        size: 7
        encoding: ASCII
        doc: 'An identifier for tracking trades'
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'Indicates the market center or exchange that originated the message'
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
  label:
    seq:
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The bond issue symbol as assigned by Finra for Trace trade reporting purposes'
      - id: cusip
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The universal identifier for the specific bond as assigned by the Cusip Service Bureau'
      - id: bsym
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Bloomberg identifier for the specific corporate bond'
      - id: sub_product_type
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the type of debt security traded'
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
      - id: quantity_indicator
        type: u1
        enum: quantity_indicator
        doc: 'Indicates if the quantity reported is actual or estimated'
      - id: quantity
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The par value volume of the transaction'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The bond price inclusive of any commission, mark-ups, and/or mark-downs reported by the sell-side firm'
      - id: remuneration
        type: u1
        enum: remuneration
        doc: 'Identifies if the reported trade price includes remuneration'
      - id: special_price_indicator
        type: u1
        enum: special_price_indicator
        doc: 'Indicates the existence of a special trade condition that impacted the execution price'
      - id: side
        type: u1
        enum: side
        doc: 'Identifies the side from the reporting party''s perspective'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'Populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: future_use
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'Indicates if there are any special conditions or modifiers applicable to the trade transaction'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Describes a second sale condition that is applicable to the trade'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: yield_direction
        type: u1
        enum: yield_direction
        doc: 'Indicates the yield direction for the subsequent Yield field'
      - id: yield_field
        type: str
        size: 13
        encoding: ASCII
        doc: 'Indicates the effective rate of return earned on a security'
      - id: when_issued_indicator
        type: u1
        enum: when_issued_indicator
        doc: 'Indicates if the issue is trading on a when issued basis'
      - id: reporting_party_type
        type: u1
        enum: reporting_party_type
        doc: 'Identifies the type of entity that reported the trade'
      - id: contra_party_type
        type: u1
        enum: contra_party_type
        doc: 'Identifies the type of contra party which the reported trade was executed against'
      - id: ats_indicator
        type: u1
        enum: ats_indicator
        doc: 'Populated if the transaction being reported is an Ats execution'
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
  settlement_date:
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
  trade_cancel_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: original_trade_identifier
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the id of the original outbound message for the transaction being reversed'
      - id: report_function
        type: u1
        enum: report_function
        doc: 'Indicates if the transaction being disseminated is being taken out'
      - id: original_trade_information
        type: original_trade_information
        doc: 'Original Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  original_trade_information:
    seq:
      - id: quantity_indicator
        type: u1
        enum: quantity_indicator
        doc: 'Indicates if the quantity reported is actual or estimated'
      - id: quantity
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The par value volume of the transaction'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The bond price inclusive of any commission, mark-ups, and/or mark-downs reported by the sell-side firm'
      - id: remuneration
        type: u1
        enum: remuneration
        doc: 'Identifies if the reported trade price includes remuneration'
      - id: special_price_indicator
        type: u1
        enum: special_price_indicator
        doc: 'Indicates the existence of a special trade condition that impacted the execution price'
      - id: side
        type: u1
        enum: side
        doc: 'Identifies the side from the reporting party''s perspective'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'Populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: future_use
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'Indicates if there are any special conditions or modifiers applicable to the trade transaction'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Describes a second sale condition that is applicable to the trade'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: yield_direction
        type: u1
        enum: yield_direction
        doc: 'Indicates the yield direction for the subsequent Yield field'
      - id: yield_field
        type: str
        size: 13
        encoding: ASCII
        doc: 'Indicates the effective rate of return earned on a security'
      - id: when_issued_indicator
        type: u1
        enum: when_issued_indicator
        doc: 'Indicates if the issue is trading on a when issued basis'
      - id: reporting_party_type
        type: u1
        enum: reporting_party_type
        doc: 'Identifies the type of entity that reported the trade'
      - id: contra_party_type
        type: u1
        enum: contra_party_type
        doc: 'Identifies the type of contra party which the reported trade was executed against'
      - id: ats_indicator
        type: u1
        enum: ats_indicator
        doc: 'Populated if the transaction being reported is an Ats execution'
  trade_summary_information:
    seq:
      - id: high_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The current highest price for which the specified bond issue was traded for the current day'
      - id: high_yield_direction
        type: u1
        enum: high_yield_direction
        doc: 'Indicates the yield direction for the High Price Yield field'
      - id: high_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The yield associated with the high price of the day'
      - id: low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The current low price for which the specified bond issue was traded for the day'
      - id: low_yield_direction
        type: u1
        enum: low_yield_direction
        doc: 'Indicates the yield direction for the Low Price field'
      - id: low_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The yield associated with the low price of the day'
      - id: last_sale_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last sale price reported for the specific bond for the day'
      - id: last_sale_yield_direction
        type: u1
        enum: last_sale_yield_direction
        doc: 'Indicates the yield direction for the Last Sale Yield field'
      - id: last_sale_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The yield associated with the last price of the day'
      - id: change_indicator
        type: u1
        enum: change_indicator
        doc: 'Describes the price change(s) that the transaction caused for the issue traded'
  trade_correction_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: original_trade_identifier
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the id of the original outbound message for the transaction being reversed'
      - id: report_function
        type: u1
        enum: report_function
        doc: 'Indicates if the transaction being disseminated is being taken out'
      - id: original_trade_information
        type: original_trade_information
        doc: 'Original Trade Information'
      - id: correction_trade_information
        type: correction_trade_information
        doc: 'Correction Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  correction_trade_information:
    seq:
      - id: quantity_indicator
        type: u1
        enum: quantity_indicator
        doc: 'Indicates if the quantity reported is actual or estimated'
      - id: quantity
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The par value volume of the transaction'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The bond price inclusive of any commission, mark-ups, and/or mark-downs reported by the sell-side firm'
      - id: remuneration
        type: u1
        enum: remuneration
        doc: 'Identifies if the reported trade price includes remuneration'
      - id: special_price_indicator
        type: u1
        enum: special_price_indicator
        doc: 'Indicates the existence of a special trade condition that impacted the execution price'
      - id: side
        type: u1
        enum: side
        doc: 'Identifies the side from the reporting party''s perspective'
      - id: as_of_indicator
        type: u1
        enum: as_of_indicator
        doc: 'Populated if the transaction being reported is an As/Of trade, Reversal, Cancel or Correction from a prior business day'
      - id: execution_datetime
        type: execution_datetime
        doc: 'Execution Datetime'
      - id: future_use
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'Indicates if there are any special conditions or modifiers applicable to the trade transaction'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Describes a second sale condition that is applicable to the trade'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: yield_direction
        type: u1
        enum: yield_direction
        doc: 'Indicates the yield direction for the subsequent Yield field'
      - id: yield_field
        type: str
        size: 13
        encoding: ASCII
        doc: 'Indicates the effective rate of return earned on a security'
      - id: when_issued_indicator
        type: u1
        enum: when_issued_indicator
        doc: 'Indicates if the issue is trading on a when issued basis'
      - id: reporting_party_type
        type: u1
        enum: reporting_party_type
        doc: 'Identifies the type of entity that reported the trade'
      - id: contra_party_type
        type: u1
        enum: contra_party_type
        doc: 'Identifies the type of contra party which the reported trade was executed against'
      - id: ats_indicator
        type: u1
        enum: ats_indicator
        doc: 'Populated if the transaction being reported is an Ats execution'
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
            'administrative_message_type::daily_trade_summary_message': daily_trade_summary_message
            'administrative_message_type::trading_halt_message': trading_halt_message
            'administrative_message_type::general_administrative_message': general_administrative_message
            'administrative_message_type::market_breadth_message': market_breadth_message
            'administrative_message_type::market_sentiment_all_securities_message': market_sentiment_all_securities_message
            'administrative_message_type::market_sentiment_investment_grade_message': market_sentiment_investment_grade_message
            'administrative_message_type::market_sentiment_high_yield_message': market_sentiment_high_yield_message
            'administrative_message_type::market_sentiment_convertible_bonds_message': market_sentiment_convertible_bonds_message
            'administrative_message_type::market_sentiment_church_bonds_message': market_sentiment_church_bonds_message
            'administrative_message_type::market_sentiment_equity_linked_notes_message': market_sentiment_equity_linked_notes_message
  daily_trade_summary_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: when_issued_indicator
        type: u1
        enum: when_issued_indicator
        doc: 'Indicates if the issue is trading on a when issued basis'
      - id: daily_high_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The high price reported for the specific bond for the day'
      - id: high_yield_direction
        type: u1
        enum: high_yield_direction
        doc: 'Indicates the yield direction for the High Price Yield field'
      - id: daily_high_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The high yield associated with the Daily High Price'
      - id: daily_low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The low price reported for the specific bond for the day'
      - id: low_yield_direction
        type: u1
        enum: low_yield_direction
        doc: 'Indicates the yield direction for the Low Price field'
      - id: daily_low_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The low yield associated with the Daily Low Price'
      - id: daily_close_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The closing price reported for the specific bond for the day'
      - id: close_yield_direction
        type: u1
        enum: close_yield_direction
        doc: 'Indicates the yield direction for the Daily Close Yield field'
      - id: daily_close_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The closing yield associated with the Daily Close Price'
  trading_halt_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'The name of the corporation or agency that issued the security'
      - id: action
        type: u1
        enum: action
        doc: 'Describes what event is happening on the specific security'
      - id: action_datetime
        type: action_datetime
        doc: 'Action Datetime'
      - id: halt_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Describes the specific reason for a halt being placed on a bond issue'
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
  general_administrative_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: text
        type: str
        size: _parent._parent.mold_udp64.length - 24
        encoding: ASCII
  market_breadth_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_breadth_information
        type: market_breadth_information
        doc: 'Market Breadth Information'
  market_breadth_information:
    seq:
      - id: total_securities_traded_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_securities_traded_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_securities_traded_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_securities_traded_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: advances_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than the prior closing price'
      - id: advances_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than the prior closing price'
      - id: advances_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than the prior closing price'
      - id: advances_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than the prior closing price'
      - id: declines_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than the prior closing price'
      - id: declines_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than the prior closing price'
      - id: declines_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than the prior closing price'
      - id: declines_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than the prior closing price'
      - id: unchanged_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day remains the same as the prior closing price'
      - id: unchanged_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day remains the same as the prior closing price'
      - id: unchanged_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day remains the same as the prior closing price'
      - id: unchanged_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day remains the same as the prior closing price'
      - id: fifty_two_week_high_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_high_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_high_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_high_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is higher than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_low_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_low_investment_grade
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_low_high_yield
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than a prior closing price within the past 52 business weeks'
      - id: fifty_two_week_low_convertibles
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues where the closing price for the day is lower than a prior closing price within the past 52 business weeks'
      - id: total_volume_all_securities
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_volume_investment_grade
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_volume_high_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_volume_convertibles
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
  market_sentiment_all_securities_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
  market_sentiment_information:
    seq:
      - id: total_number_of_transactions_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_all_securities
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_all_securities
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_number_of_transactions_customer_buy
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_customer_buy
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_customer_buy
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_number_of_transactions_customer_sell
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_customer_sell
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_customer_sell
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_number_of_transactions_affiliate_buy
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_affiliate_buy
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_affiliate_buy
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_number_of_transactions_affiliate_sell
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_affiliate_sell
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_affiliate_sell
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
      - id: total_number_of_transactions_inter_dealer
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of valid trades reported on the day'
      - id: total_securities_traded_inter_dealer
        type: str
        size: 6
        encoding: ASCII
        doc: 'The total number of issues traded on the day'
      - id: total_volume_inter_dealer
        type: str
        size: 13
        encoding: ASCII
        doc: 'The current day''s total traded par value in millions'
  market_sentiment_investment_grade_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
  market_sentiment_high_yield_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
  market_sentiment_convertible_bonds_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
  market_sentiment_church_bonds_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
  market_sentiment_equity_linked_notes_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: market_sentiment_information
        type: market_sentiment_information
        doc: 'Market Sentiment Information'
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
            'control_message_type::end_of_trade_reporting_message': end_of_trade_reporting_message
            'control_message_type::end_of_transmissions_message': end_of_transmissions_message
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
  end_of_trade_reporting_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
  end_of_transmissions_message:
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
    0x4d:
      id: 'trade_report_message'
      doc: 'Used to transmit corporate bond, church bond and equity-linked note trade transaction information'
    0x4e:
      id: 'trade_cancel_message'
      doc: 'Used to notify subscribers that a trade report entered during the current business day, or up to the past 19 business days, has been cancelled'
    0x4f:
      id: 'trade_correction_message'
      doc: 'Used to transmit trade correction data from a transaction that was entered either earlier in the day or within the past 19 business days'
  market_center_originator_id:
    0x4f:
      id: 'over_the_counter'
      doc: 'Over The Counter'
  quantity_indicator:
    0x41:
      id: 'actual'
      doc: 'Actual'
    0x45:
      id: 'estimated'
      doc: 'Estimated'
  remuneration:
    0x43:
      id: 'commission_is_included_in_the_price'
      doc: 'Commission Is Included In The Price'
    0x4d:
      id: 'a_markup_or_markdown_is_included_in_the_price'
      doc: 'A Markup Or Markdown Is Included In The Price'
    0x4e:
      id: 'no_commission_or_markup_markdown_is_included_in_the_price'
      doc: 'No Commission Or Markup Markdown Is Included In The Price'
    0x20:
      id: 'no_value_assigned_on_inter_dealer_trades'
      doc: 'No Value Assigned On Inter Dealer Trades'
  special_price_indicator:
    0x59:
      id: 'special_price_trade'
      doc: 'Special Price Trade'
    0x20:
      id: 'not_a_special_price_trade'
      doc: 'Not A Special Price Trade'
  side:
    0x42:
      id: 'reporting_party_bought_from_contra_party'
      doc: 'Reporting Party Bought From Contra Party'
    0x53:
      id: 'reporting_party_sold_to_contra_party'
      doc: 'Reporting Party Sold To Contra Party'
  as_of_indicator:
    0x41:
      id: 'as_of_trade'
      doc: 'As Of Trade'
    0x52:
      id: 'reversal'
      doc: 'Reversal'
    0x20:
      id: 'current_day_trade'
      doc: 'Current Day Trade'
  sale_condition_3:
    0x20:
      id: 'no_special_sale_condition'
      doc: 'No Special Sale Condition'
    0x5a:
      id: 'trade_reported_late_out_of_sequence'
      doc: 'Trade Reported Late Out Of Sequence'
    0x54:
      id: 'trade_reported_after_market_hours'
      doc: 'Trade Reported After Market Hours'
    0x55:
      id: 'trade_reported_late_after_market_hours'
      doc: 'Trade Reported Late After Market Hours'
  sale_condition_4:
    0x57:
      id: 'weighted_average_price'
      doc: 'Weighted Average Price'
    0x50:
      id: 'portfolio_trade'
      doc: 'Portfolio Trade'
    0x20:
      id: 'no_second_modifier_applicable'
      doc: 'No Second Modifier Applicable'
  yield_direction:
    0x2d:
      id: 'negative_yield'
      doc: 'Negative Yield'
    0x20:
      id: 'positive_or_zero_yield'
      doc: 'Positive Or Zero Yield'
  when_issued_indicator:
    0x57:
      id: 'when_issued'
      doc: 'When Issued'
    0x20:
      id: 'not_when_issued'
      doc: 'Not When Issued'
  reporting_party_type:
    0x44:
      id: 'reporting_party_is_a_broker_dealer'
      doc: 'Reporting Party Is A Broker Dealer'
    0x54:
      id: 'reporting_party_is_an_alternative_trading_system_ats'
      doc: 'Reporting Party Is An Alternative Trading System Ats'
  contra_party_type:
    0x44:
      id: 'contra_party_is_a_broker_dealer'
      doc: 'Contra Party Is A Broker Dealer'
    0x43:
      id: 'contra_party_is_a_customer_non_finra_member'
      doc: 'Contra Party Is A Customer Non Finra Member'
    0x41:
      id: 'contra_party_is_a_nonmember_affiliate'
      doc: 'Contra Party Is A Nonmember Affiliate'
    0x54:
      id: 'contra_party_is_an_alternative_trading_system_ats'
      doc: 'Contra Party Is An Alternative Trading System Ats'
  ats_indicator:
    0x59:
      id: 'ats_trade'
      doc: 'Ats Trade'
    0x20:
      id: 'not_an_ats_trade'
      doc: 'Not An Ats Trade'
  change_indicator:
    0x30:
      id: 'no_price_yield_changed'
      doc: 'No Price Yield Changed'
    0x31:
      id: 'last_price_yield_changed'
      doc: 'Last Price Yield Changed'
    0x32:
      id: 'low_price_yield_changed'
      doc: 'Low Price Yield Changed'
    0x33:
      id: 'last_price_yield_and_low_price_yield_changed'
      doc: 'Last Price Yield And Low Price Yield Changed'
    0x34:
      id: 'high_price_yield_changed'
      doc: 'High Price Yield Changed'
    0x35:
      id: 'last_price_yield_and_high_price_yield_changed'
      doc: 'Last Price Yield And High Price Yield Changed'
    0x36:
      id: 'high_price_yield_and_low_price_yield_changed'
      doc: 'High Price Yield And Low Price Yield Changed'
    0x37:
      id: 'all_prices_yields_changed'
      doc: 'All Prices Yields Changed'
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
  high_yield_direction:
    0x2d:
      id: 'negative_yield'
      doc: 'Negative Yield'
    0x20:
      id: 'positive_or_zero_yield'
      doc: 'Positive Or Zero Yield'
  low_yield_direction:
    0x2d:
      id: 'negative_yield'
      doc: 'Negative Yield'
    0x20:
      id: 'positive_or_zero_yield'
      doc: 'Positive Or Zero Yield'
  last_sale_yield_direction:
    0x2d:
      id: 'negative_yield'
      doc: 'Negative Yield'
    0x20:
      id: 'positive_or_zero_yield'
      doc: 'Positive Or Zero Yield'
  administrative_message_type:
    0x45:
      id: 'daily_trade_summary_message'
      doc: 'Price summary message disseminated for each 144A security that traded during the day during the normal trading hours'
    0x48:
      id: 'trading_halt_message'
      doc: 'Disseminated when a trading halt is instituted or removed for a 144A security'
    0x41:
      id: 'general_administrative_message'
      doc: 'Free-form text message format to relay general administrative information'
    0x31:
      id: 'market_breadth_message'
      doc: 'End of day market breadth aggregate data for Trace eligible publicly traded securities'
    0x32:
      id: 'market_sentiment_all_securities_message'
      doc: 'End of day market sentiment aggregate data for all securities'
    0x33:
      id: 'market_sentiment_investment_grade_message'
      doc: 'End of day market sentiment aggregate data for investment grade bonds'
    0x34:
      id: 'market_sentiment_high_yield_message'
      doc: 'End of day market sentiment aggregate data for high yield bonds'
    0x35:
      id: 'market_sentiment_convertible_bonds_message'
      doc: 'End of day market sentiment aggregate data for convertible bonds'
    0x36:
      id: 'market_sentiment_church_bonds_message'
      doc: 'End of day market sentiment aggregate data for church bonds'
    0x37:
      id: 'market_sentiment_equity_linked_notes_message'
      doc: 'End of day market sentiment aggregate data for equity linked notes'
  close_yield_direction:
    0x2d:
      id: 'negative_yield'
      doc: 'Negative Yield'
    0x20:
      id: 'positive_or_zero_yield'
      doc: 'Positive Or Zero Yield'
  action:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x52:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
  control_message_type:
    0x49:
      id: 'start_of_day_message'
      doc: 'Signifies the beginning of each operational cycle'
    0x4a:
      id: 'end_of_day_message'
      doc: 'Signifies the end of each operational cycle'
    0x4f:
      id: 'market_session_open_message'
      doc: 'Signifies the opening of the market session'
    0x43:
      id: 'market_session_close_message'
      doc: 'Signifies the closing of the market session'
    0x58:
      id: 'end_of_trade_reporting_message'
      doc: 'Signifies the end of the trade reporting session'
    0x5a:
      id: 'end_of_transmissions_message'
      doc: 'Signifies that no further transmissions will be sent for the day'

