# ---------------------------------------------------------------------
# Kaitai struct definition for: Finra FinraOtc Bbds Dfi v2018.1A
#
# Protocol:
#   Organization: Financial Industry Regulatory Authority
#   Protocol: Bulletin Board Dissemination Service
#   Encoding: Data Feed Interface
#   Version: 2018.1A
#   Date: 5/14/2018
#   Specification: FINRA BBDS Data Feed Interface Specification (2018-1A).pdf
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
  id: finra_finraotc_bbds_dfi_v2018_1a
  title: Finra FinraOtc Bbds Dfi v2018.1A
  license: GPL-3.0
  endian: be

doc: 'Financial Industry Regulatory Authority Finra OTC Bulletin Board Dissemination Service Dfi v2018.1A'
doc-ref: https://www.finra.org/filing-reporting/otcbb/otcbb-forms-documentation

seq:
  - id: block_soh
    type: u1
    doc: 'start of messages'
  - id: message
    type: message_struct
    repeat: eos

types:
  message_struct:
    seq:
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Message Category'
      - id: payload
        type:
          switch-on: message_category
          cases:
            'message_category::quotation': quotation_message
            'message_category::administrative': administrative_message
            'message_category::control': control_message
      - id: message_separator
        type: u1
        enum: message_separator
        doc: 'message separator'
  quotation_message:
    seq:
      - id: quotation_message_type
        type: u1
        enum: quotation_message_type
        doc: 'Quotation message type'
      - id: quotation_message_payload
        type:
          switch-on: quotation_message_type
          cases:
            'quotation_message_type::market_participant_quote_update_message': market_participant_quote_update_message
  market_participant_quote_update_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: otcbb_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'This alphanumeric field indicates the issue symbol for the OTCBB security being quoted'
      - id: otcbb_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This alphanumeric field indicates if the OTCBB issue being quoted is eligible for real-time or indicative updates'
      - id: market_participant_identifier
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Market Participant Identifier (MPID) field indicates the identifier assigned by FINRA to the OTCBB Market Participant that is responsible for generating a quotation message'
      - id: market_participant_location_id
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Market Participant Location ID field identifies the branch or trading desk at Market Maker firm or ECN responsible for entering and maintaining quote in the give OTCBB issue'
      - id: market_participant_status
        type: u1
        enum: market_participant_status
        doc: 'This alphanumeric field indicates the current status for the Market Participant position for the issue'
      - id: market_participant_quote_condition
        type: u1
        enum: market_participant_quote_condition
        doc: 'The Market Participant Quote Condition field indicates the current quotation state for a Market Participant in a given OTCBB issue'
      - id: reserved_1
        size: 1
        doc: 'This field will be space filled'
      - id: wanted_indicator
        type: u1
        enum: wanted_indicator
        doc: 'The Offer Wanted/Bid Wanted Indicator field indicates a special, unpriced OTCBB quotation from a market participant'
      - id: unsolicited_indicator
        type: u1
        enum: unsolicited_indicator
        doc: 'The Unsolicited Indicator field indicates if the Market Participant is entering an unsolicited quote in a given security'
      - id: bid_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Bid Price Denominator denotes the whole dollar and decimal digit composition of the Ask Price field'
      - id: bid_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The Bid Price is the price at which the OTCBB quoting participant is willing to buy the security for at a given time'
      - id: bid_size
        type: str
        size: 7
        encoding: ASCII
        doc: 'The Bid Size represents the amount of shares available at the quoting participant’s Bid Price in the given security'
      - id: ask_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Ask Price Denominator denotes the whole dollar and decimal digit composition of the Ask Price field'
      - id: ask_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The Ask price is the price at which the quoting participant is willing to sell (offer) the security for at any given time'
      - id: ask_size
        type: str
        size: 7
        encoding: ASCII
        doc: 'The Ask Size represents the amount of shares available at the quoting participant’s Ask Price in the given security'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the currency in which the trade transaction was reported'
      - id: inside_appendage_indicator
        type: u1
        enum: inside_appendage_indicator
        doc: 'The Inside Appendage Indicator field indicates how the Inside quote for the OTCBB issue is impacted by the current Market Participant update'
      - id: inside_appendage
        type: inside_appendage
        if: inside_appendage_indicator == inside_appendage_indicator::inside_quote_appendage_is_attached
        doc: 'Inside Appendage'
  message_header:
    seq:
      - id: session_identifier
        type: u1
        enum: session_identifier
        doc: 'This field indicates the market session of the message'
      - id: retransmission_requester
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates if the message is an original transmission or retransmission'
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Message Sequence Number, at the beginning of each operational cycle, this number will be set to 00000000 of each data channel'
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'This field indicates the market center or system that originated the message that follows'
      - id: datetime
        type: datetime
        doc: 'Datetime'
      - id: reserved_1
        size: 1
        doc: 'This field will be space filled'
  datetime:
    seq:
      - id: year
        type: str
        size: 2
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: u1
        enum: month
        doc: 'The month the transaction occurred'
      - id: day
        type: u1
        enum: day
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: u1
        enum: hour
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: u1
        enum: minute
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: u1
        enum: second
        doc: 'The second of the minute the transaction occurred'
  inside_appendage:
    seq:
      - id: inside_quote_condition
        type: u1
        enum: inside_quote_condition
        doc: 'This Function field denotes if the original trade report is being cancelled or was reported in error'
      - id: inside_bid_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Inside Bid Price Denominator field denotes the whole dollar and decimal digit composition of the Inside Ask Price field'
      - id: inside_bid_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The Inside Bid Price indicates the best (highest) bid price available in the OTCBB system for the issue'
      - id: inside_bid_size
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Inside Bid Size field indicates the largest size (in round lots) quoted by an OTCBB market participant at the Inside Price in the issue'
      - id: inside_ask_price_denominator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Inside Ask Price Denominator field denotes the whole dollar and decimal digit composition of the Inside Ask Price field'
      - id: inside_ask_price
        type: str
        size: 12
        encoding: ASCII
        doc: 'The Inside Ask Price indicates the best ask price available in the OTCBB system for the issue'
      - id: inside_ask_size
        type: str
        size: 12
        encoding: ASCII
        doc: 'This Inside Ask Size field indicates the largest size (in round lots) quoted by an OTCBB market participant at the Inside Price in the issue'
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
            'administrative_message_type::trading_action_message': trading_action_message
  general_administrative_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: text
        type: str
        size: 
        encoding: ASCII
        doc: 'Free-form text is used to notify data feed subscribers of corporate actions or special trading situations'
  trading_action_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message Header'
      - id: stock_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'This alphanumeric field indicates the issue symbol for the OTCBB security that is impacted by the FINRA Trading Action'
      - id: action
        type: u1
        enum: action
        doc: 'Indicates the current trading status for the stated issue'
      - id: action_datetime
        type: action_datetime
        doc: 'Action Datetime'
      - id: reason_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Reason Code indicates the reason for the current trading action status'
  action_datetime:
    seq:
      - id: year
        type: str
        size: 2
        encoding: ASCII
        doc: 'The year the transaction occurred'
      - id: month
        type: u1
        enum: month
        doc: 'The month the transaction occurred'
      - id: day
        type: u1
        enum: day
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: u1
        enum: hour
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: u1
        enum: minute
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: u1
        enum: second
        doc: 'The second of the minute the transaction occurred'
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
    0x51:
      id: 'quotation'
      doc: 'Quotation Messages Header'
    0x41:
      id: 'administrative'
      doc: 'Administrative Messages Header'
    0x43:
      id: 'control'
      doc: 'Control Messages Header'
  quotation_message_type:
    0x31:
      id: 'market_participant_quote_update_message'
      doc: 'The following message format will be used to disseminate the best-priced quotation for all OTCBB quoting participants and the Inside Quote in each issue'
  session_identifier:
    0x41:
      id: 'all_market_sessions_or_session_independent'
      doc: 'All Market Sessions or Session Independent'
    0x55:
      id: 'us_market_session'
      doc: 'US Market Session'
  market_center_originator_id:
    0x45:
      id: 'market_center_independent'
      doc: 'Market Center Independent'
    0x55:
      id: 'otc_bulletin_board'
      doc: 'OTC Bulletin Board'
    0x51:
      id: 'nasdaq_omx_market_system'
      doc: 'Used for specific Market System Events only'
  month:
    49:
      id: 'month_1'
      doc: 'Month 1, sent as ''1'' (0x31)'
    50:
      id: 'month_2'
      doc: 'Month 2, sent as ''2'' (0x32)'
    51:
      id: 'month_3'
      doc: 'Month 3, sent as ''3'' (0x33)'
    52:
      id: 'month_4'
      doc: 'Month 4, sent as ''4'' (0x34)'
    53:
      id: 'month_5'
      doc: 'Month 5, sent as ''5'' (0x35)'
    54:
      id: 'month_6'
      doc: 'Month 6, sent as ''6'' (0x36)'
    55:
      id: 'month_7'
      doc: 'Month 7, sent as ''7'' (0x37)'
    56:
      id: 'month_8'
      doc: 'Month 8, sent as ''8'' (0x38)'
    57:
      id: 'month_9'
      doc: 'Month 9, sent as ''9'' (0x39)'
    58:
      id: 'month_10'
      doc: 'Month 10, sent as '':'' (0x3A)'
    59:
      id: 'month_11'
      doc: 'Month 11, sent as '';'' (0x3B)'
    60:
      id: 'month_12'
      doc: 'Month 12, sent as ''<'' (0x3C)'
  day:
    49:
      id: 'day_1'
      doc: 'Day 1, sent as ''1'' (0x31)'
    50:
      id: 'day_2'
      doc: 'Day 2, sent as ''2'' (0x32)'
    51:
      id: 'day_3'
      doc: 'Day 3, sent as ''3'' (0x33)'
    52:
      id: 'day_4'
      doc: 'Day 4, sent as ''4'' (0x34)'
    53:
      id: 'day_5'
      doc: 'Day 5, sent as ''5'' (0x35)'
    54:
      id: 'day_6'
      doc: 'Day 6, sent as ''6'' (0x36)'
    55:
      id: 'day_7'
      doc: 'Day 7, sent as ''7'' (0x37)'
    56:
      id: 'day_8'
      doc: 'Day 8, sent as ''8'' (0x38)'
    57:
      id: 'day_9'
      doc: 'Day 9, sent as ''9'' (0x39)'
    58:
      id: 'day_10'
      doc: 'Day 10, sent as '':'' (0x3A)'
    59:
      id: 'day_11'
      doc: 'Day 11, sent as '';'' (0x3B)'
    60:
      id: 'day_12'
      doc: 'Day 12, sent as ''<'' (0x3C)'
    61:
      id: 'day_13'
      doc: 'Day 13, sent as ''='' (0x3D)'
    62:
      id: 'day_14'
      doc: 'Day 14, sent as ''>'' (0x3E)'
    63:
      id: 'day_15'
      doc: 'Day 15, sent as ''?'' (0x3F)'
    64:
      id: 'day_16'
      doc: 'Day 16, sent as ''@'' (0x40)'
    65:
      id: 'day_17'
      doc: 'Day 17, sent as ''A'' (0x41)'
    66:
      id: 'day_18'
      doc: 'Day 18, sent as ''B'' (0x42)'
    67:
      id: 'day_19'
      doc: 'Day 19, sent as ''C'' (0x43)'
    68:
      id: 'day_20'
      doc: 'Day 20, sent as ''D'' (0x44)'
    69:
      id: 'day_21'
      doc: 'Day 21, sent as ''E'' (0x45)'
    70:
      id: 'day_22'
      doc: 'Day 22, sent as ''F'' (0x46)'
    71:
      id: 'day_23'
      doc: 'Day 23, sent as ''G'' (0x47)'
    72:
      id: 'day_24'
      doc: 'Day 24, sent as ''H'' (0x48)'
    73:
      id: 'day_25'
      doc: 'Day 25, sent as ''I'' (0x49)'
    74:
      id: 'day_26'
      doc: 'Day 26, sent as ''J'' (0x4A)'
    75:
      id: 'day_27'
      doc: 'Day 27, sent as ''K'' (0x4B)'
    76:
      id: 'day_28'
      doc: 'Day 28, sent as ''L'' (0x4C)'
    77:
      id: 'day_29'
      doc: 'Day 29, sent as ''M'' (0x4D)'
    78:
      id: 'day_30'
      doc: 'Day 30, sent as ''N'' (0x4E)'
    79:
      id: 'day_31'
      doc: 'Day 31, sent as ''O'' (0x4F)'
  hour:
    48:
      id: 'hour_0'
      doc: 'Hour 0, sent as ''0'' (0x30)'
    49:
      id: 'hour_1'
      doc: 'Hour 1, sent as ''1'' (0x31)'
    50:
      id: 'hour_2'
      doc: 'Hour 2, sent as ''2'' (0x32)'
    51:
      id: 'hour_3'
      doc: 'Hour 3, sent as ''3'' (0x33)'
    52:
      id: 'hour_4'
      doc: 'Hour 4, sent as ''4'' (0x34)'
    53:
      id: 'hour_5'
      doc: 'Hour 5, sent as ''5'' (0x35)'
    54:
      id: 'hour_6'
      doc: 'Hour 6, sent as ''6'' (0x36)'
    55:
      id: 'hour_7'
      doc: 'Hour 7, sent as ''7'' (0x37)'
    56:
      id: 'hour_8'
      doc: 'Hour 8, sent as ''8'' (0x38)'
    57:
      id: 'hour_9'
      doc: 'Hour 9, sent as ''9'' (0x39)'
    58:
      id: 'hour_10'
      doc: 'Hour 10, sent as '':'' (0x3A)'
    59:
      id: 'hour_11'
      doc: 'Hour 11, sent as '';'' (0x3B)'
    60:
      id: 'hour_12'
      doc: 'Hour 12, sent as ''<'' (0x3C)'
    61:
      id: 'hour_13'
      doc: 'Hour 13, sent as ''='' (0x3D)'
    62:
      id: 'hour_14'
      doc: 'Hour 14, sent as ''>'' (0x3E)'
    63:
      id: 'hour_15'
      doc: 'Hour 15, sent as ''?'' (0x3F)'
    64:
      id: 'hour_16'
      doc: 'Hour 16, sent as ''@'' (0x40)'
    65:
      id: 'hour_17'
      doc: 'Hour 17, sent as ''A'' (0x41)'
    66:
      id: 'hour_18'
      doc: 'Hour 18, sent as ''B'' (0x42)'
    67:
      id: 'hour_19'
      doc: 'Hour 19, sent as ''C'' (0x43)'
    68:
      id: 'hour_20'
      doc: 'Hour 20, sent as ''D'' (0x44)'
    69:
      id: 'hour_21'
      doc: 'Hour 21, sent as ''E'' (0x45)'
    70:
      id: 'hour_22'
      doc: 'Hour 22, sent as ''F'' (0x46)'
    71:
      id: 'hour_23'
      doc: 'Hour 23, sent as ''G'' (0x47)'
  minute:
    48:
      id: 'minute_0'
      doc: 'Minute 0, sent as ''0'' (0x30)'
    49:
      id: 'minute_1'
      doc: 'Minute 1, sent as ''1'' (0x31)'
    50:
      id: 'minute_2'
      doc: 'Minute 2, sent as ''2'' (0x32)'
    51:
      id: 'minute_3'
      doc: 'Minute 3, sent as ''3'' (0x33)'
    52:
      id: 'minute_4'
      doc: 'Minute 4, sent as ''4'' (0x34)'
    53:
      id: 'minute_5'
      doc: 'Minute 5, sent as ''5'' (0x35)'
    54:
      id: 'minute_6'
      doc: 'Minute 6, sent as ''6'' (0x36)'
    55:
      id: 'minute_7'
      doc: 'Minute 7, sent as ''7'' (0x37)'
    56:
      id: 'minute_8'
      doc: 'Minute 8, sent as ''8'' (0x38)'
    57:
      id: 'minute_9'
      doc: 'Minute 9, sent as ''9'' (0x39)'
    58:
      id: 'minute_10'
      doc: 'Minute 10, sent as '':'' (0x3A)'
    59:
      id: 'minute_11'
      doc: 'Minute 11, sent as '';'' (0x3B)'
    60:
      id: 'minute_12'
      doc: 'Minute 12, sent as ''<'' (0x3C)'
    61:
      id: 'minute_13'
      doc: 'Minute 13, sent as ''='' (0x3D)'
    62:
      id: 'minute_14'
      doc: 'Minute 14, sent as ''>'' (0x3E)'
    63:
      id: 'minute_15'
      doc: 'Minute 15, sent as ''?'' (0x3F)'
    64:
      id: 'minute_16'
      doc: 'Minute 16, sent as ''@'' (0x40)'
    65:
      id: 'minute_17'
      doc: 'Minute 17, sent as ''A'' (0x41)'
    66:
      id: 'minute_18'
      doc: 'Minute 18, sent as ''B'' (0x42)'
    67:
      id: 'minute_19'
      doc: 'Minute 19, sent as ''C'' (0x43)'
    68:
      id: 'minute_20'
      doc: 'Minute 20, sent as ''D'' (0x44)'
    69:
      id: 'minute_21'
      doc: 'Minute 21, sent as ''E'' (0x45)'
    70:
      id: 'minute_22'
      doc: 'Minute 22, sent as ''F'' (0x46)'
    71:
      id: 'minute_23'
      doc: 'Minute 23, sent as ''G'' (0x47)'
    72:
      id: 'minute_24'
      doc: 'Minute 24, sent as ''H'' (0x48)'
    73:
      id: 'minute_25'
      doc: 'Minute 25, sent as ''I'' (0x49)'
    74:
      id: 'minute_26'
      doc: 'Minute 26, sent as ''J'' (0x4A)'
    75:
      id: 'minute_27'
      doc: 'Minute 27, sent as ''K'' (0x4B)'
    76:
      id: 'minute_28'
      doc: 'Minute 28, sent as ''L'' (0x4C)'
    77:
      id: 'minute_29'
      doc: 'Minute 29, sent as ''M'' (0x4D)'
    78:
      id: 'minute_30'
      doc: 'Minute 30, sent as ''N'' (0x4E)'
    79:
      id: 'minute_31'
      doc: 'Minute 31, sent as ''O'' (0x4F)'
    80:
      id: 'minute_32'
      doc: 'Minute 32, sent as ''P'' (0x50)'
    81:
      id: 'minute_33'
      doc: 'Minute 33, sent as ''Q'' (0x51)'
    82:
      id: 'minute_34'
      doc: 'Minute 34, sent as ''R'' (0x52)'
    83:
      id: 'minute_35'
      doc: 'Minute 35, sent as ''S'' (0x53)'
    84:
      id: 'minute_36'
      doc: 'Minute 36, sent as ''T'' (0x54)'
    85:
      id: 'minute_37'
      doc: 'Minute 37, sent as ''U'' (0x55)'
    86:
      id: 'minute_38'
      doc: 'Minute 38, sent as ''V'' (0x56)'
    87:
      id: 'minute_39'
      doc: 'Minute 39, sent as ''W'' (0x57)'
    88:
      id: 'minute_40'
      doc: 'Minute 40, sent as ''X'' (0x58)'
    89:
      id: 'minute_41'
      doc: 'Minute 41, sent as ''Y'' (0x59)'
    90:
      id: 'minute_42'
      doc: 'Minute 42, sent as ''Z'' (0x5A)'
    91:
      id: 'minute_43'
      doc: 'Minute 43, sent as ''['' (0x5B)'
    92:
      id: 'minute_44'
      doc: 'Minute 44, sent as ''\'' (0x5C)'
    93:
      id: 'minute_45'
      doc: 'Minute 45, sent as '']'' (0x5D)'
    94:
      id: 'minute_46'
      doc: 'Minute 46, sent as ''^'' (0x5E)'
    95:
      id: 'minute_47'
      doc: 'Minute 47, sent as ''_'' (0x5F)'
    96:
      id: 'minute_48'
      doc: 'Minute 48, sent as ''`'' (0x60)'
    97:
      id: 'minute_49'
      doc: 'Minute 49, sent as ''a'' (0x61)'
    98:
      id: 'minute_50'
      doc: 'Minute 50, sent as ''b'' (0x62)'
    99:
      id: 'minute_51'
      doc: 'Minute 51, sent as ''c'' (0x63)'
    100:
      id: 'minute_52'
      doc: 'Minute 52, sent as ''d'' (0x64)'
    101:
      id: 'minute_53'
      doc: 'Minute 53, sent as ''e'' (0x65)'
    102:
      id: 'minute_54'
      doc: 'Minute 54, sent as ''f'' (0x66)'
    103:
      id: 'minute_55'
      doc: 'Minute 55, sent as ''g'' (0x67)'
    104:
      id: 'minute_56'
      doc: 'Minute 56, sent as ''h'' (0x68)'
    105:
      id: 'minute_57'
      doc: 'Minute 57, sent as ''i'' (0x69)'
    106:
      id: 'minute_58'
      doc: 'Minute 58, sent as ''j'' (0x6A)'
    107:
      id: 'minute_59'
      doc: 'Minute 59, sent as ''k'' (0x6B)'
  second:
    48:
      id: 'second_0'
      doc: 'Second 0, sent as ''0'' (0x30)'
    49:
      id: 'second_1'
      doc: 'Second 1, sent as ''1'' (0x31)'
    50:
      id: 'second_2'
      doc: 'Second 2, sent as ''2'' (0x32)'
    51:
      id: 'second_3'
      doc: 'Second 3, sent as ''3'' (0x33)'
    52:
      id: 'second_4'
      doc: 'Second 4, sent as ''4'' (0x34)'
    53:
      id: 'second_5'
      doc: 'Second 5, sent as ''5'' (0x35)'
    54:
      id: 'second_6'
      doc: 'Second 6, sent as ''6'' (0x36)'
    55:
      id: 'second_7'
      doc: 'Second 7, sent as ''7'' (0x37)'
    56:
      id: 'second_8'
      doc: 'Second 8, sent as ''8'' (0x38)'
    57:
      id: 'second_9'
      doc: 'Second 9, sent as ''9'' (0x39)'
    58:
      id: 'second_10'
      doc: 'Second 10, sent as '':'' (0x3A)'
    59:
      id: 'second_11'
      doc: 'Second 11, sent as '';'' (0x3B)'
    60:
      id: 'second_12'
      doc: 'Second 12, sent as ''<'' (0x3C)'
    61:
      id: 'second_13'
      doc: 'Second 13, sent as ''='' (0x3D)'
    62:
      id: 'second_14'
      doc: 'Second 14, sent as ''>'' (0x3E)'
    63:
      id: 'second_15'
      doc: 'Second 15, sent as ''?'' (0x3F)'
    64:
      id: 'second_16'
      doc: 'Second 16, sent as ''@'' (0x40)'
    65:
      id: 'second_17'
      doc: 'Second 17, sent as ''A'' (0x41)'
    66:
      id: 'second_18'
      doc: 'Second 18, sent as ''B'' (0x42)'
    67:
      id: 'second_19'
      doc: 'Second 19, sent as ''C'' (0x43)'
    68:
      id: 'second_20'
      doc: 'Second 20, sent as ''D'' (0x44)'
    69:
      id: 'second_21'
      doc: 'Second 21, sent as ''E'' (0x45)'
    70:
      id: 'second_22'
      doc: 'Second 22, sent as ''F'' (0x46)'
    71:
      id: 'second_23'
      doc: 'Second 23, sent as ''G'' (0x47)'
    72:
      id: 'second_24'
      doc: 'Second 24, sent as ''H'' (0x48)'
    73:
      id: 'second_25'
      doc: 'Second 25, sent as ''I'' (0x49)'
    74:
      id: 'second_26'
      doc: 'Second 26, sent as ''J'' (0x4A)'
    75:
      id: 'second_27'
      doc: 'Second 27, sent as ''K'' (0x4B)'
    76:
      id: 'second_28'
      doc: 'Second 28, sent as ''L'' (0x4C)'
    77:
      id: 'second_29'
      doc: 'Second 29, sent as ''M'' (0x4D)'
    78:
      id: 'second_30'
      doc: 'Second 30, sent as ''N'' (0x4E)'
    79:
      id: 'second_31'
      doc: 'Second 31, sent as ''O'' (0x4F)'
    80:
      id: 'second_32'
      doc: 'Second 32, sent as ''P'' (0x50)'
    81:
      id: 'second_33'
      doc: 'Second 33, sent as ''Q'' (0x51)'
    82:
      id: 'second_34'
      doc: 'Second 34, sent as ''R'' (0x52)'
    83:
      id: 'second_35'
      doc: 'Second 35, sent as ''S'' (0x53)'
    84:
      id: 'second_36'
      doc: 'Second 36, sent as ''T'' (0x54)'
    85:
      id: 'second_37'
      doc: 'Second 37, sent as ''U'' (0x55)'
    86:
      id: 'second_38'
      doc: 'Second 38, sent as ''V'' (0x56)'
    87:
      id: 'second_39'
      doc: 'Second 39, sent as ''W'' (0x57)'
    88:
      id: 'second_40'
      doc: 'Second 40, sent as ''X'' (0x58)'
    89:
      id: 'second_41'
      doc: 'Second 41, sent as ''Y'' (0x59)'
    90:
      id: 'second_42'
      doc: 'Second 42, sent as ''Z'' (0x5A)'
    91:
      id: 'second_43'
      doc: 'Second 43, sent as ''['' (0x5B)'
    92:
      id: 'second_44'
      doc: 'Second 44, sent as ''\'' (0x5C)'
    93:
      id: 'second_45'
      doc: 'Second 45, sent as '']'' (0x5D)'
    94:
      id: 'second_46'
      doc: 'Second 46, sent as ''^'' (0x5E)'
    95:
      id: 'second_47'
      doc: 'Second 47, sent as ''_'' (0x5F)'
    96:
      id: 'second_48'
      doc: 'Second 48, sent as ''`'' (0x60)'
    97:
      id: 'second_49'
      doc: 'Second 49, sent as ''a'' (0x61)'
    98:
      id: 'second_50'
      doc: 'Second 50, sent as ''b'' (0x62)'
    99:
      id: 'second_51'
      doc: 'Second 51, sent as ''c'' (0x63)'
    100:
      id: 'second_52'
      doc: 'Second 52, sent as ''d'' (0x64)'
    101:
      id: 'second_53'
      doc: 'Second 53, sent as ''e'' (0x65)'
    102:
      id: 'second_54'
      doc: 'Second 54, sent as ''f'' (0x66)'
    103:
      id: 'second_55'
      doc: 'Second 55, sent as ''g'' (0x67)'
    104:
      id: 'second_56'
      doc: 'Second 56, sent as ''h'' (0x68)'
    105:
      id: 'second_57'
      doc: 'Second 57, sent as ''i'' (0x69)'
    106:
      id: 'second_58'
      doc: 'Second 58, sent as ''j'' (0x6A)'
    107:
      id: 'second_59'
      doc: 'Second 59, sent as ''k'' (0x6B)'
  market_participant_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
    0x45:
      id: 'excused'
      doc: 'Excused'
    0x57:
      id: 'withdrawn'
      doc: 'Withdrawn'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
  market_participant_quote_condition:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x49:
      id: 'periodic_indicative_other_securities'
      doc: 'Periodic Indicative Other Securities'
    0x4b:
      id: 'real_time_quotes'
      doc: 'Real-time quotes'
    0x4c:
      id: 'periodic_indicative_quotes'
      doc: 'Periodic, indicative quotes'
  wanted_indicator:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x4e:
      id: 'not_applicable'
      doc: 'Not applicable'
    0x4f:
      id: 'offer'
      doc: 'Offer'
    0x57:
      id: 'bid_and_offer'
      doc: 'Bid and Offer'
  unsolicited_indicator:
    0x41:
      id: 'unsolicited_ask'
      doc: 'Unsolicited Ask'
    0x42:
      id: 'unsolicited_bid'
      doc: 'Unsolicited Bid'
    0x55:
      id: 'unsolicited_bid_and_ask'
      doc: 'Unsolicited Bid And Ask'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  inside_appendage_indicator:
    0x31:
      id: 'no_change_to_inside_quote'
      doc: 'No change to Inside Quote'
    0x32:
      id: 'no_inside_exists'
      doc: 'No Inside exists'
    0x33:
      id: 'inside_quote_appendage_is_attached'
      doc: 'Inside Quote Appendage is attached'
  inside_quote_condition:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
  administrative_message_type:
    0x41:
      id: 'general_administrative_message'
      doc: 'A variable length, free-form text message format will be used on an as-needed basis'
    0x48:
      id: 'trading_action_message'
      doc: 'FINRA will disseminate this message to inform customers of trading actions, such as halts or trading resumptions which affect individual OTCBB or Other OTC securities'
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
  message_separator:
    31:
      id: 'unit_separator'
      doc: 'Ends a message that is not the last message in the block'
    3:
      id: 'end_of_text'
      doc: 'Ends the last message in the block'

