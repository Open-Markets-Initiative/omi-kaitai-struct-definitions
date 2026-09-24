# ---------------------------------------------------------------------
# Kaitai struct definition for: Finra Trace Spds Dfi v2.1
#
# Protocol:
#   Organization: Financial Industry Regulatory Authority
#   Protocol: Securitized Products Dissemination Service
#   Encoding: FINRA Data Feed Interface
#   Version: 2.1
#   Date: 11/19/2024
#   Specification: FINRA SPDS Specification (MOLD 1.0).pdf
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
  id: finra_trace_spds_dfi_v2_1
  title: Finra Trace Spds Dfi v2.1
  license: GPL-3.0
  endian: be

doc: 'Financial Industry Regulatory Authority Finra TRACE Securitized Products Dissemination Service Dfi v2.1'
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
            'trade_message_type::mbs_trade_report_message': mbs_trade_report_message
            'trade_message_type::trade_cancel_message': trade_cancel_message
            'trade_message_type::mbs_trade_cancel_message': mbs_trade_cancel_message
            'trade_message_type::trade_correction_message': trade_correction_message
            'trade_message_type::mbs_trade_correction_message': mbs_trade_correction_message
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
        doc: 'The security symbol assigned by Finra for Trace trade reporting purposes'
      - id: cusip
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The universal identifier for the specific security assigned by Standard and Poor''s Cusip Service Bureau'
      - id: bsym
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Bloomberg identifier for the specific security'
      - id: sub_product_type
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the type of securitized product security traded'
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: factor
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates a reported factor on a trade that was not based on the latest published factor'
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
  mbs_trade_report_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: mbs_label
        type: mbs_label
        doc: 'MBS Label'
      - id: original_dissemination_date
        type: original_dissemination_date
        doc: 'Original Dissemination Date'
      - id: mbs_trade_information
        type: mbs_trade_information
        doc: 'MBS Trade Information'
      - id: change_indicator
        type: u1
        enum: change_indicator
        doc: 'Describes the price change(s) that the transaction caused for the issue traded'
  mbs_label:
    seq:
      - id: rdid
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference data identifier included in lieu of Symbol, Cusip and Bsym identifiers'
      - id: sub_product_type
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the type of securitized product security traded'
  mbs_trade_information:
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: factor
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates a reported factor on a trade that was not based on the latest published factor'
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
        doc: 'The current highest price for which the specified issue was traded for the current day'
      - id: low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The current low price for which the specified security was traded for the day'
      - id: last_sale_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last sale price reported for the specific security for the day'
      - id: change_indicator
        type: u1
        enum: change_indicator
        doc: 'Describes the price change(s) that the transaction caused for the issue traded'
  mbs_trade_cancel_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: mbs_label
        type: mbs_label
        doc: 'MBS Label'
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
      - id: mbs_original_trade_information
        type: mbs_original_trade_information
        doc: 'MBS Original Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  mbs_original_trade_information:
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
      - id: factor
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates a reported factor on a trade that was not based on the latest published factor'
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
  mbs_trade_correction_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: mbs_label
        type: mbs_label
        doc: 'MBS Label'
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
      - id: mbs_original_trade_information
        type: mbs_original_trade_information
        doc: 'MBS Original Trade Information'
      - id: mbs_correction_trade_information
        type: mbs_correction_trade_information
        doc: 'MBS Correction Trade Information'
      - id: trade_summary_information
        type: trade_summary_information
        doc: 'Trade Summary Information'
  mbs_correction_trade_information:
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
        doc: 'The dollar size amount of the transaction, inclusive of a decimal'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The security price inclusive of any commission, mark-ups and mark-downs reported in the transaction'
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
        doc: 'Populated if the transaction being reported is an As/Of trade or Reversal from a prior business day'
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
        doc: 'Describes a sale condition that is applicable to the trade'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'Indicates special conditions or modifiers applicable to the trade transaction'
      - id: settlement_date
        type: settlement_date
        doc: 'Settlement Date'
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
            'administrative_message_type::mbs_daily_trade_summary_message': mbs_daily_trade_summary_message
            'administrative_message_type::trading_halt_message': trading_halt_message
            'administrative_message_type::general_administrative_message': general_administrative_message
  daily_trade_summary_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: label
        type: label
        doc: 'Label'
      - id: daily_high_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The high price reported for the specific security for the day'
      - id: daily_low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The low price reported for the specific security for the day'
      - id: daily_close_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The closing price reported for the specific security for the day'
  mbs_daily_trade_summary_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: mbs_label
        type: mbs_label
        doc: 'MBS Label'
      - id: daily_high_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The high price reported for the specific security for the day'
      - id: daily_low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The low price reported for the specific security for the day'
      - id: daily_close_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The closing price reported for the specific security for the day'
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
        doc: 'The name of the entity that issued the security'
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
        doc: 'Describes the specific reason for a halt being placed on a security'
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
      doc: 'Used to transmit trade transaction information for Tba, Abs and certain Cmo transactions'
    0x50:
      id: 'mbs_trade_report_message'
      doc: 'Used to transmit trade transaction information for Mbs transactions'
    0x4e:
      id: 'trade_cancel_message'
      doc: 'Notifies subscribers that a trade report entered during the past 20 business days has been cancelled'
    0x51:
      id: 'mbs_trade_cancel_message'
      doc: 'Notifies subscribers that a trade report for an Mbs entered during the past 20 business days has been cancelled'
    0x4f:
      id: 'trade_correction_message'
      doc: 'Notifies subscribers that a trade report entered during the past 20 business days has been corrected'
    0x52:
      id: 'mbs_trade_correction_message'
      doc: 'Notifies subscribers that a trade report for an Mbs entered during the past 20 business days has been corrected'
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
    0x54:
      id: 'trade_reported_after_market_hours'
      doc: 'Trade Reported After Market Hours'
    0x5a:
      id: 'trade_reported_late_out_of_sequence'
      doc: 'Trade Reported Late Out Of Sequence'
    0x55:
      id: 'trade_reported_late_after_market_hours'
      doc: 'Trade Reported Late After Market Hours'
    0x20:
      id: 'no_modifier'
      doc: 'No Modifier'
  sale_condition_4:
    0x20:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x4f:
      id: 'specified_pool_transaction'
      doc: 'Specified Pool Transaction'
    0x4e:
      id: 'stipulation_transaction'
      doc: 'Stipulation Transaction'
    0x44:
      id: 'dollar_roll_wo_stipulation'
      doc: 'Dollar Roll Wo Stipulation'
    0x4c:
      id: 'stipulated_dollar_roll'
      doc: 'Stipulated Dollar Roll'
    0x57:
      id: 'weighted_average_price'
      doc: 'Weighted Average Price'
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
      id: 'no_price_changed'
      doc: 'No Price Changed'
    0x31:
      id: 'last_price_changed'
      doc: 'Last Price Changed'
    0x32:
      id: 'low_price_changed'
      doc: 'Low Price Changed'
    0x33:
      id: 'last_price_and_low_price_changed'
      doc: 'Last Price And Low Price Changed'
    0x34:
      id: 'high_price_changed'
      doc: 'High Price Changed'
    0x35:
      id: 'last_price_and_high_price_changed'
      doc: 'Last Price And High Price Changed'
    0x36:
      id: 'high_price_and_low_price_changed'
      doc: 'High Price And Low Price Changed'
    0x37:
      id: 'all_prices_changed'
      doc: 'All Prices Changed'
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
  administrative_message_type:
    0x45:
      id: 'daily_trade_summary_message'
      doc: 'Price summary disseminated for each security that traded during the normal trading hours'
    0x46:
      id: 'mbs_daily_trade_summary_message'
      doc: 'Price summary disseminated for each Mbs that traded during the normal trading hours'
    0x48:
      id: 'trading_halt_message'
      doc: 'Disseminated when a trading halt is instituted or removed for a security'
    0x41:
      id: 'general_administrative_message'
      doc: 'Free-form text message format to relay general administrative information'
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
      doc: 'Signifies the beginning of Finra''s daily operational cycle'
    0x4a:
      id: 'end_of_day_message'
      doc: 'Signals the end of activity for the operational cycle'
    0x4f:
      id: 'market_session_open_message'
      doc: 'Signifies the opening of the market for the session indicated in the message header'
    0x43:
      id: 'market_session_close_message'
      doc: 'Signals the closing of the market for the session indicated in the message header'
    0x58:
      id: 'end_of_trade_reporting_message'
      doc: 'Signals that no further trade reports or corrections will be sent for that market session'
    0x5a:
      id: 'end_of_transmissions_message'
      doc: 'Signals that there will be no further transmissions of data'

