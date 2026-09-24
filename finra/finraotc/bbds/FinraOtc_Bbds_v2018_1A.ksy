# ---------------------------------------------------------------------
# Kaitai struct definition for: Finra FinraOtc Bbds Dfi v2018.1A
#
# Protocol:
#   Organization: Financial Industry Regulatory Authority
#   Protocol: Bulletin Board Dissemination Service
#   Encoding: Data Feed Interface
#   Version: 2018.1A
#   Date: 5/14/2018
#   Specification: BBDS_Specs_v2018-1.pdf
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
        size-eos: true
        encoding: ASCII
        doc: 'Free-form text is used to notify data feed subscribers of corporate actions or special trading situations'
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
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates the market center or system that originated the message that follows'
      - id: datetime
        type: datetime
        doc: 'Datetime'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field will be space filled'
  datetime:
    seq:
      - id: year
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The second of the minute the transaction occurred'
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
        pad-right: 0x20
        doc: 'The year the transaction occurred'
      - id: month
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The month the transaction occurred'
      - id: day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The day of the month the transaction occurred'
      - id: hour
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The hour of the day the transaction occurred in military time'
      - id: minute
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The minute of the hour the transaction occurred'
      - id: second
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
      id: 'realtime_quotes'
      doc: 'Realtime Quotes'
    0x4c:
      id: 'periodic_indicative_quotes'
      doc: 'Periodic Indicative Quotes'
  wanted_indicator:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x4f:
      id: 'offer'
      doc: 'Offer'
    0x57:
      id: 'bid_and_offer'
      doc: 'Bid And Offer'
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
      doc: 'Not Applicable'
  inside_appendage_indicator:
    0x31:
      id: 'no_change_to_inside_quote'
      doc: 'No Change To Inside Quote'
    0x32:
      id: 'no_inside_exists'
      doc: 'No Inside Exists'
    0x33:
      id: 'inside_quote_appendage_is_attached'
      doc: 'Inside Quote Appendage Is Attached'
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
  session_identifier:
    0x41:
      id: 'all_market_sessions_or_session_independent'
      doc: 'All Market Sessions Or Session Independent'
    0x55:
      id: 'us_market_session'
      doc: 'Us Market Session'
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

