# ---------------------------------------------------------------------
# Kaitai struct definition for: Qse QseCash MarketData Xdp v2.6
#
# Protocol:
#   Organization: Qatar Stock Exchange
#   Protocol: Qse Cash Market Data
#   Encoding: Exchange Data Publisher
#   Version: 2.6
#   Date: 03/01/2010
#   Specification: XDP for UTP Cash Version 2.6.pdf
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
  id: qse_qsecash_marketdata_xdp_v2_6
  title: Qse QseCash MarketData Xdp v2.6
  license: GPL-3.0
  endian: be

doc: 'Qatar Stock Exchange Qatar Stock Exchange Qse Cash Market Data Xdp v2.6'
doc-ref: https://www.qe.com.qa/real-time-data

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages contain a common packet header, so that a client implements line level protocol processing once and then develops parsing algorithms only for its choice of message'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msg_entries

types:
  packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the packet in bytes, including the 16 byte packet header'
      - id: packet_type
        type: u2
        enum: packet_type
        doc: 'Identifier for the type of data contained in the packet. If all messages within a packet are of the same message type the packet type equals that message type, and if not it is set to the generic packet type of the feed'
      - id: packet_sequence_number
        type: u4
        doc: 'The packet sequence number, unique for each broadcast stream and used for gap detection. It increases serially and monotonically and is reset to 1 at the beginning of each trading day. It is unique for packets containing market data only, and heartbeats inherit it from the last market data packet or packet sequence number reset packet'
      - id: send_time
        type: u4
        doc: 'Timestamp in milliseconds indicating the packet broadcast time. The number represents the number of milliseconds since midnight of the last Sunday 00:00 UTC, a weekly epoch no Epoch trait represents, so the field carries no epoch and a reader resolves the absolute time against the Sunday preceding the capture'
      - id: service_id
        type: u2
        doc: 'Numeric value identifying the broadcast stream. Qatar Exchange production streams are 201 Equities All Data, 202 Equities Trades and Quotes, 204 Equities Orders, 207 Indices Composition and Values, 208 Off Exchange Trade Reporting Referential Data and 209 Off Exchange Trade Reporting Trade Reporting'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Indicates delivery method, and a client uses it to determine whether a packet is ZliB compressed'
      - id: number_msg_entries
        type: u1
        doc: 'The number of messages that are contained within the packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::stock_state_change_message': stock_state_change_message
            'message_type::class_state_change_message': class_state_change_message
            'message_type::mail_message': mail_message
            'message_type::indicative_matching_price_message': indicative_matching_price_message
            'message_type::collars_message': collars_message
            'message_type::session_timetable_message': session_timetable_message
            'message_type::global_market_activity_summary_message': global_market_activity_summary_message
            'message_type::start_referential_message': start_referential_message
            'message_type::end_referential_message': end_referential_message
            'message_type::referential_message': referential_message
            'message_type::trade_creation_message': trade_creation_message
            'message_type::trade_cancellation_message': trade_cancellation_message
            'message_type::trade_full_information_message': trade_full_information_message
            'message_type::price_update_message': price_update_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::vwap_closing_price_message': vwap_closing_price_message
            'message_type::quotes_message': quotes_message
            'message_type::order_update_market_sheet_message': order_update_market_sheet_message
            'message_type::orderbook_retransmission_delimiter_message': orderbook_retransmission_delimiter_message
            'message_type::real_time_index_message': real_time_index_message
            'message_type::index_summary_message': index_summary_message
            'message_type::index_composition_message': index_composition_message
            'message_type::start_refresh_message': start_refresh_message
            'message_type::end_refresh_message': end_refresh_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  stock_state_change_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: filler_binary_int_2
        size: 2
        doc: 'For future use'
      - id: start_date_halting
        type: yyyymmdd_ascii_date
        doc: 'Date when suspension of trading started for an instrument'
      - id: start_time_halting
        type: hhmmss_ascii_time
        doc: 'Time when suspension of trading started for an instrument'
      - id: prog_opening_time
        type: hhmmss_ascii_time
        doc: 'Instrument opening time that has been programmed by the Cash Market Operations'
      - id: order_entry_rejection
        type: u1
        enum: order_entry_rejection
        doc: 'Indicates whether order entry is allowed or forbidden'
      - id: instrument_state
        type: u1
        enum: instrument_state
        doc: 'Indicates the state of the instrument'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Indicates whether trading on an instrument is suspended, halted or resumed:'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Indicates the origin of halting for an instrument'
      - id: action_affecting_state
        type: u1
        enum: action_affecting_state
        doc: 'Code indicating the event that caused a change in the instrument state'
      - id: instrument_state_tcs
        type: u1
        enum: instrument_state_tcs
        doc: 'Indicates if trade declaration/reporting is authorized in TCS'
      - id: period_side
        type: u1
        enum: period_side
        doc: 'This indicator indicates the side phase for an instrument being in a Bid only situation or Offer only situation'
      - id: filler_binary_int_1
        size: 1
        doc: 'For future use'
  class_state_change_message:
    seq:
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Instrument Group / Class Identification'
      - id: instrument_group_state
        type: u1
        enum: instrument_group_state
        doc: 'For NSC traded instrument-groups only'
      - id: session_type
        type: u1
        enum: session_type
        doc: 'Market Session'
      - id: filler_binary_int_1
        size: 1
        doc: 'For future use'
      - id: class_state
        type: str
        size: 4
        encoding: ASCII
        doc: 'For UTP traded instruments only'
  mail_message:
    seq:
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: e_mail_msg_number
        type: u2
        doc: 'Helps in rebuilding a mail message that was sent in several messages'
      - id: number_of_message
        type: u2
        doc: 'Helps in rebuilding a mail message that was sent in several transmission (between 1 to 20)'
      - id: sequence_number
        type: u2
        doc: 'Current sequence number message'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Instrument Group / Class Identification'
      - id: filler_ascii_str_1
        size: 1
        doc: 'For future use'
      - id: priority_indicator
        type: u1
        enum: priority_indicator
        doc: 'Urgency of the mail, valid values: ‘O’ - Urgent message'
      - id: type_of_message
        type: u1
        enum: type_of_message
        doc: 'General contents of the message'
      - id: address_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates the users to whom the message is addressed'
      - id: title
        type: str
        size: 80
        encoding: ASCII
        doc: 'Title of the mail'
      - id: text
        type: str
        size: 854
        encoding: ASCII
        doc: 'Text, line break (@), page break (#)'
      - id: filler_ascii_str_2
        size: 2
        doc: 'For future use'
  indicative_matching_price_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: im_price
        type: u4
        doc: 'Indicative Matching Price: Price at which transaction on a security would occur if Opening occurred at this moment (To be calculated with the PriceScaleCode)'
      - id: variation
        type: u4
        doc: 'Percentage variation of the last IMP against the previous day’s (signed) reference price for the stock concerned, ie the last known price can be the last adjusted closing price or the last price indication (if an indication was entered after the last traded price).(To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
      - id: im_volume
        type: u4
        doc: 'Indicative Matching Volume: Volume that would be exchanged if Auction occurred at this moment'
  collars_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: high_collar
        type: u4
        doc: 'Higher bound of the collar price range (To be calculated with the HighScaleCode)'
      - id: low_collar
        type: u4
        doc: 'Lower bound of the collar price range (To be calculated with the LowScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: high_scale_code
        type: u1
        doc: 'To be combined with HighCollar'
      - id: low_scale_code
        type: u1
        doc: 'To be combined with LowCollar'
      - id: collar_type
        type: u1
        enum: collar_type
        doc: 'Defines the type of collars: D Dynamic collars S Static thresholds'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  session_timetable_message:
    seq:
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Instrument Group / Class Identification'
      - id: session_type
        type: u1
        enum: session_type
        doc: 'Market Session'
      - id: time_pre_opening_1
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the pre-opening time of the Class / Instrument Group for the session'
      - id: time_opening_1
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the opening time of the Class / Instrument Group for the session'
      - id: time_closing_1
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the closing time of the Class / Instrument Group for the session nd'
      - id: time_pre_opening_2
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the pre-opening time of 2 auction nd'
      - id: time_opening_2
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the opening time of 2 auction nd'
      - id: time_closing_2
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the closing time of 2 auction rd'
      - id: time_pre_opening_3
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the pre-opening time of 3 auction rd'
      - id: time_opening_3
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the opening time of 3 auction rd'
      - id: time_closing_3
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates, if applicable, the closing time of 3 auction'
      - id: eod_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time of End of day inquiry / Late Monitoring'
      - id: filler_ascii_str_2
        size: 2
        doc: 'For future use'
  global_market_activity_summary_message:
    seq:
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: nb_trades
        type: u4
        doc: 'Number of Trades executed on the market since the beginning of the Trading Day'
      - id: qty_shares
        type: u4
        doc: 'Cumulated Quantity traded (number of shares) on the market since the beginning of the Trading Day'
      - id: amount_traded
        type: u4
        doc: 'Total cumulated amount traded on the market since the beginning of the Trading day (To be calculated with the PriceScaleCode)'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  start_referential_message:
    seq:
      - id: indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field indicates the start of the Instrument characteristic flow'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  end_referential_message:
    seq:
      - id: indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field indicates the start of the Instrument characteristic flow'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  referential_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: last_adj_price
        type: u4
        doc: 'Last traded price of the previous trading day after application of the adjustment coefficient (To be calculated with the LastAdjPriceScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: prev_volume_traded
        type: u4
        doc: 'Number of shares traded on this security during trading day identified by ''DateOfLastTrade'''
      - id: fix_price_tick
        type: u4
        doc: 'Indicates the amount of the fixed tick size, if it has been defined at the instrument level'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: stock_exchange_code
        type: u2
        doc: 'Indicates the Market Place'
      - id: type_of_instrument
        type: u2
        doc: 'Type of instrument'
      - id: event_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Date of the last modification of the characteristics of the instrument except the following ones (which are modified every day): - Previous day’s adjusted closing price (LastAdjPrice) - Previous day capital traded (PrevDayCapitalTraded) - Number of shares for this security traded on previous day (PrevVolumeTraded) - Date when the security last traded (DateOfLastTrade)'
      - id: instrument_name
        type: str
        size: 18
        encoding: ASCII
        doc: 'Instrument Name'
      - id: period_indicator
        type: u1
        enum: period_indicator
        doc: 'Indicates for which day the characteristics of the instrument will be effective'
      - id: type_of_market_admission
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of market to which a security has been listed'
      - id: issuing_country_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Country code of location for the corporate headquarters of the company that issued the instrument'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Code of the currency in which the instrument is traded'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Instrument Group / Class Identification'
      - id: instrument_category
        type: u1
        enum: instrument_category
        doc: 'Indicates to which category, the security belongs'
      - id: instrument_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Isin Code, International Securities Identification Number, according to the ISO-6166'
      - id: date_of_last_trade
        type: yyyymmdd_ascii_date
        doc: 'Date of the last trading day during which a trade was executed for the instrument'
      - id: underlying_repo_isin_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying security (security used in the loan quotation system) for loan contracts at given value on centralized lending market'
      - id: repo_expiry_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Represents the inclusive date until which a lending/borrowing contract can be traded'
      - id: first_settlement_date
        type: yyyymmdd_ascii_date
        doc: 'Represents the first possible settlement date for a given instrument with the instrument''s depository'
      - id: type_of_derivatives
        type: u1
        enum: type_of_derivatives
        doc: 'Type of derivative instrument associated to the security'
      - id: bic_depositary
        type: str
        size: 11
        encoding: ASCII
        doc: 'Identifies the depository organization for the shares of an instrument, or when the same organization manages several systems, this item identifies the relevant settlement system for settling trades on a given listed security'
      - id: icb
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies for a listed instrument, the economic subsector of the issuing company in the ICB (Industry Classification Benchmark) classification'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the market to which an instrument y belongs by its MIC (Market Identification code), according to ISO 10383'
      - id: underlying_wisin_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Gives the trading code of the underlying listed security of a warrant'
      - id: depositary_list
        type: str
        size: 25
        encoding: ASCII
        doc: 'Identifies the possible main depository organizations (max 5) for the shares or bonds for an instrument'
      - id: main_depositary
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies the default (or main) depository organisation of the instrument (for Euronext, between the possible 5 depositaries registered for Euronext markets) used by priority for the settlement (e.g.: multi-listed instruments which have several depositories)'
      - id: type_of_corporate_event
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates the last type of corporate event that has occurred on an instrument, such as detachment of rights, or of coupons'
      - id: time_lag_euronext_utc
        type: str
        size: 5
        encoding: ASCII
        doc: 'Used for Euronext/MiFID: Effective difference time between CET (Euronext time) and UTC'
      - id: time_lag_mi_fid_reg_utc
        type: str
        size: 5
        encoding: ASCII
        doc: 'Used for Euronext/MiFID: Effective time difference between MiFID regulators and UTC'
      - id: cfi
        type: str
        size: 6
        encoding: ASCII
        doc: 'Classification code of a financial instrument defined by the ISO-10962 standard'
      - id: quantity_notation
        type: str
        size: 4
        encoding: ASCII
        doc: 'Specifies the nature of the amount expression used for negotiating the instrument on the market'
      - id: index_set_of_var_price_tick
        type: str
        size: 2
        encoding: ASCII
        doc: 'When the instrument''s tick is defined via a Variable Tick Table: The key for the variable price tick table consists of two data items [the index for a set of variable price ticks, the lowest value in a range of prices]'
      - id: market_feed_code
        type: str
        size: 2
        encoding: ASCII
        doc: '"Market data flow" to which the instrument belongs'
      - id: mic_list
        type: str
        size: 24
        encoding: ASCII
        doc: 'Identifies the markets on which a security is listed by its MIC (Market Identification Code)'
      - id: industry_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Not used'
      - id: industry_text
        type: str
        size: 100
        encoding: ASCII
        doc: 'Not used'
      - id: financial_market_code
        type: str
        size: 3
        encoding: ASCII
        doc: 'Refer to appendix B'
      - id: us_indicators
        type: str
        size: 7
        encoding: ASCII
        doc: 'Not used'
      - id: filler_ascii_str_2
        size: 2
        doc: 'For future use'
      - id: prev_day_capital_traded
        type: u8
        doc: 'Cumulative capital traded for all previous day trades on a security (To be calculated with the PrevDayCapitalTradedScaleCode)'
      - id: nom_mkt_price
        type: u8
        doc: 'Amount of the nominal value of the security (To be calculated with the NomMktPriceScaleCode)'
      - id: lot_size
        type: u8
        doc: 'Expressed in number of shares or in an amount or a volume of the capital, of the lot size'
      - id: number_instrument_circ
        type: u8
        doc: 'Number of shares issued/bonds outstanding after payments'
      - id: shares_out
        type: u8
        doc: 'Not used'
      - id: auth_shares
        type: u8
        doc: 'Not used OfficialQuotationList 416 Gives the section, heading and sub-headings in which the security is in HeadingNumber 2 Binary Int'
      - id: heading_number
        type: u2
        doc: 'Gives the heading in which the security is in the Bulletin de la Cote Officielle. Used in Euronext only'
      - id: section_number
        type: u1
        doc: 'Gives the section in which the security is in the Bulletin de la Cote Officielle. Used in Euronext only'
      - id: repo_indicator
        type: u1
        enum: repo_indicator
        doc: 'Indicates whether the security listed underlies any loan contracts, meaning it has been admitted to the Deferred Settlement system and/or to the lending market'
      - id: last_adj_price_scale_code
        type: u1
        doc: 'To be combined with LastAdjPrice'
      - id: type_of_unit_exp
        type: u1
        enum: type_of_unit_exp
        doc: 'Unit in which the security is quoted'
      - id: market_indicator
        type: u1
        enum: market_indicator
        doc: 'Indicates the market regulations governing the market on which the security is traded'
      - id: prev_day_capital_traded_scale_code
        type: u1
        doc: 'To be combined with PrevDayCapitalTraded'
      - id: tax_code
        type: u1
        enum: tax_code
        doc: 'Tax deduction code to which the security belongs'
      - id: nom_mkdt_price_scale_code
        type: u1
        doc: 'To be combined with NomMkdtPrice'
      - id: lot_size_scale_code
        type: u1
        doc: 'To be combined with LotSize'
      - id: fix_price_tick_scale_code
        type: u1
        doc: 'To be combined with FixPriceTick'
      - id: mnemo
        type: str
        size: 5
        encoding: ASCII
        doc: 'Mnemonic code of the instrument'
      - id: trading_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Trading code of the instrument'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
      - id: strike_price
        type: u4
        doc: 'The specified price of an option contract at which the contract may be exercised, whereby a call option buyer can buy the underlying or a put option buyer can sell the underlying'
      - id: strike_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Code for the currency of the strike price applied for an instrument whose maturity is reached (ISO 4217-3A)'
      - id: strike_scale_code
        type: u1
        doc: 'To be combined with StrikePrice'
      - id: currency_coef
        type: u4
        doc: 'Change ratio coefficient of currency applied to instrument: Used in conjunction with one of the change rate indicators in order to apply this coefficient to a currency among two available currencies defined for the instrument: - Trading currency - Currency code of strike price for Derivative Instrument The currency to which this coefficient will be applied depends on just one of the two values set to the related indicators (defined below in the integrity constraints)'
      - id: currency_coef_scale_code
        type: u1
        doc: 'To be combined with CurrencyCoef'
      - id: trading_currency_indicator
        type: u1
        doc: 'Change rate indicator for currency of Instrument Traded Price: Indicates if the change rate will be applied to the currency defined for traded prices of the instrument'
      - id: strike_currency_indicator
        type: u1
        doc: 'Change rate indicator for currency of the strike price Indicates if the change rate will be applied to the currency defined for strike prices of the instrument'
      - id: market_segment
        type: str
        size: 2
        encoding: ASCII
        doc: 'Qatar Exchange only: Market segment'
      - id: algo
        type: u1
        enum: algo
        doc: 'Qatar Exchange only: Indicates which trading algorithm is used'
      - id: local_name
        type: str
        size: 30
        encoding: ASCII
        doc: 'Qatar Exchange only: Instrument name in local language (Arabic character set ISO-8859-6 for QE)'
      - id: small_trade
        type: u4
        doc: 'Qatar Exchange only: Instrument trade amount under which a trade is considered as small'
      - id: filler_binary_int_12
        size: 12
        doc: 'For future use'
  trade_creation_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: trade_id_number
        type: u4
        doc: 'Unique numeric and increasing Identifier of the trade, set by the trading engine'
      - id: quote_link_id
        type: u4
        doc: 'Identifies a unique quote that the Trade executed against'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: price
        type: u4
        doc: 'Price of the trade (To be calculated with the PriceScaleCode)'
      - id: volume
        type: u4
        doc: 'Number of shares transacted in this trade'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: small_trade_indicator
        type: u1
        enum: small_trade_indicator
        doc: 'QATAR EXCHANGE ONLY: This field indicates if the trade is a small trade or not'
      - id: trad_cond_2
        type: u1
        enum: trad_cond_2
        doc: 'Sequencing related conditions, Last of a series of trades at the same price'
      - id: trad_cond_3
        type: u1
        enum: trad_cond_3
        doc: 'Trade related conditions, Cross trade indicator'
      - id: trade_origin
        type: u1
        enum: trade_origin
        doc: 'QATAR EXCHANGE ONLY: Field Name Offset Size Format Description (Bytes) This field indicates the origin of the trade'
      - id: opening_trade_indicator
        type: u1
        enum: opening_trade_indicator
        doc: 'If the trade took place during the opening auction or during the core session'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
  trade_cancellation_message:
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
      - id: original_trade_id_number
        type: u4
        doc: 'This field refers to the initial TradeIDNumber of the trade concerned (as reported in a 220/240 message) in this cancellation message'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: filler_binary_int_2
        size: 2
        doc: 'For future use'
  trade_full_information_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: trade_id_number
        type: u4
        doc: 'Unique numeric and increasing Identifier of the trade, set by the trading engine'
      - id: quote_link_id
        type: u4
        doc: 'Identifies a unique quote that the Trade executed against'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: price
        type: u4
        doc: 'Price of the trade (To be calculated with the PriceScaleCode)'
      - id: volume
        type: u4
        doc: 'Number of shares transacted in this trade'
      - id: cumulative_quantity
        type: u4
        doc: 'Cumulative number of shares traded on UTP/NSC since the start of the current trading session'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: variation_last_price
        type: u4
        doc: 'Percentage variation of today’s price/last reference price(To be (signed) calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: filler_binary_int_2
        size: 2
        doc: 'For future use'
      - id: small_trade_indicator
        type: u1
        enum: small_trade_indicator
        doc: 'QATAR EXCHANGE ONLY: This field indicates if the trade is a small trade or not'
      - id: trad_cond_2
        type: u1
        enum: trad_cond_2
        doc: 'Sequencing related conditions, Last of a series of trades at the same price'
      - id: trad_cond_3
        type: u1
        enum: trad_cond_3
        doc: 'Trade related conditions, Cross trade indicator'
      - id: trade_origin
        type: u1
        enum: trade_origin
        doc: 'QATAR EXCHANGE ONLY: Field Name Offset Size Format Description (Bytes) This field indicates the origin of the trade'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'Symbol of the variation of the price versus the previous (traded or reference) price, valid values: ‘+’ - positive ‘-‘ - negative ‘0’ - no variation or data field not significant Null - not significant'
      - id: opening_trade_indicator
        type: u1
        enum: opening_trade_indicator
        doc: 'If the trade took place during the opening auction or during the core session'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
  price_update_message:
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
      - id: price
        type: u4
        doc: 'Price of the trade (To be calculated with the PriceScaleCode)'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: variation_last_price
        type: u4
        doc: 'Percentage variation of today’s price/last reference price(To be (signed) calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: type_of_price
        type: u2
        enum: type_of_price
        doc: 'Market- Code identifying the type of price that is updated'
      - id: filler_binary_int_2
        size: 2
        doc: 'For future use'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
  auction_summary_message:
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
      - id: first_price
        type: u4
        doc: 'First traded price for the current trading day (To be calculated with the PriceScaleCode)'
      - id: last_price
        type: u4
        doc: 'Most recent traded price for the current trading day (To be calculated with the PriceScaleCode)'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: cumulative_quantity
        type: u4
        doc: 'Cumulative number of shares traded on UTP/NSC since the start of the current trading session'
      - id: variation
        type: u4
        doc: 'Percentage variation of the last IMP against the previous day’s (signed) reference price for the stock concerned, ie the last known price can be the last adjusted closing price or the last price indication (if an indication was entered after the last traded price).(To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: type_of_last_price
        type: u2
        enum: type_of_last_price
        doc: 'Indicates the message trade type'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'Symbol of the variation of the price versus the previous (traded or reference) price, valid values: ‘+’ - positive ‘-‘ - negative ‘0’ - no variation or data field not significant Null - not significant'
      - id: instrument_valuation_price
        type: u1
        enum: instrument_valuation_price
        doc: 'Indicates whether the data item “last price” is a valuation price'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
  vwap_closing_price_message:
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
      - id: sending_indicator
        type: u2
        doc: 'Indicate the "sending mode" that can be: 1 - Real Time 2 - Batch mode'
      - id: closing_price_rule
        type: u2
        doc: 'Indicate the Closing Price calculation rule, that can be: 1 - LTP (Last Traded Price) 2 - VWAP (Volume Weighted Average Price)'
      - id: closing_price
        type: u4
        doc: 'Current VWAP/Closing Price (To be calculated with the PriceScaleCode)'
      - id: adjusted_closing_price
        type: u4
        doc: 'Adjusted VWAP/Closing Price (To be calculated with the PriceScaleCode)'
      - id: nb_trades
        type: u4
        doc: 'Number of Trades executed on the market since the beginning of the Trading Day'
      - id: qty_shares
        type: u4
        doc: 'Cumulated Quantity traded (number of shares) on the market since the beginning of the Trading Day'
      - id: amount_traded
        type: u4
        doc: 'Total cumulated amount traded on the market since the beginning of the Trading day (To be calculated with the PriceScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  quotes_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: quote_link_id
        type: u4
        doc: 'Identifies a unique quote that the Trade executed against'
      - id: ask_price
        type: u4
        doc: 'Ask Price for Quote (To be calculated with the ScaleCode) Specific values: FF FF FF FE: Market Order or Market To Limit Order FF FF FF FD At Opening Order (NSC only)'
      - id: ask_size
        type: u4
        doc: 'Total number of shares requested in sell orders at the ask price'
      - id: bid_price
        type: u4
        doc: 'Bid Price for Quote (To be calculated with the ScaleCode) Specific values: FF FF FF FE: Market Order or Market To Limit Order FF FF FF FD At Opening Order (NSC only)'
      - id: bid_size
        type: u4
        doc: 'Total number of shares requested in buy orders at the bid price'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: number_ask_orders
        type: u2
        doc: 'Number of sell orders at the ask price'
      - id: number_bid_orders
        type: u2
        doc: 'Number of buy orders at the bid price'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: type_of_ask_price
        type: u1
        enum: type_of_ask_price
      - id: type_of_bid_price
        type: u1
        enum: type_of_bid_price
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Liquidity provider presence indicator:'
      - id: quote_number
        type: u1
        doc: 'Indicates the level in the order book for the given aggregate quote, derived from it’s price value'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: filler_ascii_str_1
        size: 1
        doc: 'For future use'
  order_update_market_sheet_message:
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
      - id: price
        type: u4
        doc: 'Price of the trade (To be calculated with the PriceScaleCode)'
      - id: aggregated_volume
        type: u4
        doc: 'Total quantity at the price of the current order'
      - id: volume
        type: u4
        doc: 'Number of shares transacted in this trade'
      - id: link_id
        type: u4
        doc: 'The LinkID identifies a unique transaction in the matching and allows you to correlate execution reports and quotes to the last sale'
      - id: order_id
        type: u4
        doc: 'Identifies the uniqueness of the order, when combined with OrderDate'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: number_orders
        type: u2
        doc: 'Number of orders in the Book at the price of the current order'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the side of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of Order'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'This field identifies why the volume (size) at the (current order) price was modified'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: order_date
        type: u4
        doc: 'Date of order (YYYYMMDD)'
      - id: order_priority_date
        type: u4
        doc: 'Date giving the priority of the order (YYYYMMDD)'
      - id: order_priority_time
        type: hhmmssmmm_time
        doc: 'Time giving the priority of the order (HHMMSSsss)'
      - id: order_priority_micro_secs
        type: u2
        doc: 'Number of micro seconds in the current millisecond'
      - id: order_origin
        type: str
        size: 1
        encoding: ASCII
        doc: 'QATAR EXCHANGE ONLY: Order Origin (so that the FIFO-Origin priority can be determined)'
      - id: filler_binary_int_1
        size: 1
        doc: 'For future use'
  orderbook_retransmission_delimiter_message:
    seq:
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: trading_engine_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'Code identifying the trading engine'
      - id: instance_id
        type: u1
        doc: 'Indicates the number of instances for a given trading engine rebroadcasting orderbooks'
      - id: retransmission_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the status of the retransmission for the instance of the trading engine: ''B'' Beginning of the retransmission ''E'' End of the retransmission'
  real_time_index_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: index_level
        type: u4
        doc: 'The value of the last level for the index that is the subject of this message To be calculated with the LevelScaleCode)'
      - id: forerunner_level
        type: u4
        doc: 'The percentage of variation of the last Forerunner level for the index (signed) that is the subject of this message, if any (To be calculated with the LevelScaleCode)'
      - id: session_high
        type: u4
        doc: 'Highest level of the day (To be calculated with the LevelScaleCode)'
      - id: session_low
        type: u4
        doc: 'Lowest level of the day (To be calculated with the LevelScaleCode)'
      - id: percentage_of_capitalization
        type: u4
        doc: 'Percentage of capitalization for the active instruments in the index (To be calculated with the PercentageScaleCode)'
      - id: variation_from_previous_days_price
        type: s4
        doc: 'Percentage of variation for day''s index / Previous day''s reference (To sPrice (signed) be calculated with the VariationScaleCode) Field Name Offset Size Format Description (Bytes)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: num_of_securities_quoted
        type: u2
        doc: 'Number of instruments in the index that have actually traded (active instruments)'
      - id: index_level_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Index Level Code'
      - id: type_of_level
        type: str
        size: 1
        encoding: ASCII
        doc: '‘1’ - Price level ‘2’ - Gross profitability level ‘3’ - Net profitability level'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with IndexLevel, ForerunnerLevel, SessionHigh, SessionLow'
      - id: percentage_scale_code
        type: u1
        doc: 'To be combined with PercentageOfCapitalization'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
      - id: rebroadcast_indicator
        type: u1
        enum: rebroadcast_indicator
        doc: 'On occasion the 542 message carrying the closing level of the previous day is rebroadcast at the beginning of the trading day'
      - id: filler_ascii_str_2
        size: 2
        doc: 'For future use'
  index_summary_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: preliminary_opening_level
        type: u4
        doc: 'Preliminary Opening index level(To be calculated with the LevelScaleCode)'
      - id: preliminary_opening_time
        type: millisecond_timestamp
        doc: 'Time of provisional opening index level. Milliseconds since Midnight epoch'
      - id: first_level
        type: u4
        doc: 'First index level broadcast (To be calculated with the LevelScaleCode)'
      - id: first_time
        type: millisecond_timestamp
        doc: 'Time of provisional first index level. Milliseconds since Midnight epoch'
      - id: opening_reference_level
        type: u4
        doc: 'Reference opening index level (To be calculated with the LevelScaleCode)'
      - id: opening_reference_time
        type: millisecond_timestamp
        doc: 'Time of provisional opening reference index level. Milliseconds since Midnight epoch'
      - id: closing_reference_level
        type: u4
        doc: 'Reference closing index level (To be calculated with the LevelScaleCode)'
      - id: closing_reference_time
        type: millisecond_timestamp
        doc: 'Time of provisional closing reference index level. Milliseconds since Midnight epoch'
      - id: percent_variation_prev_clos
        type: u4
        doc: 'Percentage of variation for last index level vs'
      - id: high_level
        type: u4
        doc: 'Highest index level (To be calculated with the LevelScaleCode)'
      - id: high_time
        type: millisecond_timestamp
        doc: 'Time of provisional highest index level. Milliseconds since Midnight epoch'
      - id: low_level
        type: u4
        doc: 'Lowest index level (To be calculated with the LevelScaleCode)'
      - id: low_time
        type: millisecond_timestamp
        doc: 'Time of provisional lowest index level. Milliseconds since Midnight epoch'
      - id: clearing_level
        type: u4
        doc: 'Reference daily settlement index level (To be calculated with the LevelScaleCode)'
      - id: clearing_time
        type: millisecond_timestamp
        doc: 'Time of provisional daily settlement index level. Milliseconds since Midnight epoch'
      - id: liquidation_level
        type: u4
        doc: 'Reference at-expiration settlement index level (To be calculated with the LevelScaleCode)'
      - id: liquidation_time
        type: millisecond_timestamp
        doc: 'Time of provisional expiation settlement index level. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: type_of_level
        type: str
        size: 1
        encoding: ASCII
        doc: '‘1’ - Price level ‘2’ - Gross profitability level ‘3’ - Net profitability level'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with IndexLevel, ForerunnerLevel, SessionHigh, SessionLow'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
      - id: filler_ascii_str_3
        size: 3
        doc: 'For future use'
  index_composition_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: instrument_weight
        type: u4
        doc: 'Instrument''s weight (in %) in previous day''s reference capitalization of the index (To be calculated with the PriceScaleCode)'
      - id: instrument_factor
        type: u4
        doc: 'Capitalization adjustment coefficient of an instrument in the index (To be calculated with the PriceScaleCode)'
      - id: previous_close
        type: u4
        doc: 'Previous day''s reference closing level for the index (To be calculated with the LevelScaleCode)'
      - id: system_id
        type: u4
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: number_of_conponents
        type: u2
        doc: 'Total number of instruments in the index'
      - id: instrument_id_of_component
        type: str
        size: 12
        encoding: ASCII
        doc: 'Trading code (if any, else ISIN code) ID of index component'
      - id: mnemo
        type: str
        size: 5
        encoding: ASCII
        doc: 'Mnemonic code of the instrument'
      - id: index_frequency
        type: str
        size: 1
        encoding: ASCII
        doc: 'Frequency of index calculation: ‘C’ - Continuous calculation ‘D’ - Discontinuous calculation'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: level_scale_code
        type: u1
        doc: 'To be combined with IndexLevel, ForerunnerLevel, SessionHigh, SessionLow'
  start_refresh_message:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Contains the last cached PacketSeqNum that the Refresh is valid to'
  end_refresh_message:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Contains the last cached PacketSeqNum that the Refresh is valid to'
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
  hhmmssmmm_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000000 % 100
      minute:
        value: time / 100000 % 100
      second:
        value: time / 1000 % 100
      millisecond:
        value: time % 1000

enums:
  packet_type:
    994:
      id: 'generic_quotes'
      doc: 'Generic Quotes, all current quotes (5/10BBO''s)'
    995:
      id: 'generic_market_information'
      doc: 'Generic Market Information, current Data dictionary for stocks and indices'
    996:
      id: 'generic_indices'
      doc: 'Generic Indices, current indices values'
    998:
      id: 'generic_trades'
      doc: 'Generic Trades, last trades for each instrument'
    230:
      id: 'generic_orderbook'
      doc: 'Generic Orderbook, current snapshot of the order book'
    999:
      id: 'refresh_combined_packet_type'
      doc: 'Refresh combined packet type, used when a refresh packet contains different generic packet types'
  delivery_flag:
    0:
      id: 'real_time_message_uncompressed'
      doc: 'Real Time message (Uncompressed)'
    2:
      id: 'retransmission_message_uncompressed'
      doc: 'Retransmission message (Uncompressed)'
    17:
      id: 'refresh_message_zlib_compressed'
      doc: 'Refresh message (ZliB Compressed)'
  message_type:
    505:
      id: 'stock_state_change_message'
      doc: 'A Stock State Change message is generated by the trading engines to announce a change in the state of an instrument.'
    516:
      id: 'class_state_change_message'
      doc: 'A Class State Change message announces a change in the trading market phase of a class or instrument group, which instruments belonging to it inherit.'
    523:
      id: 'mail_message'
      doc: 'A Mail message carries a free text notice broadcast to market participants.'
    530:
      id: 'indicative_matching_price_message'
      doc: 'An Indicative Matching Price message gives the price at which the instrument would open, were the opening to occur at this moment.'
    537:
      id: 'collars_message'
      doc: 'A Collars message gives the upper and lower price thresholds beyond which an instrument is reserved.'
    539:
      id: 'session_timetable_message'
      doc: 'A Session Timetable message gives the timetable of the trading session for a group of instruments.'
    545:
      id: 'global_market_activity_summary_message'
      doc: 'A Global Market Activity Summary message provides an overall summary of the global market activity. This message is used only at Qatar Exchange.'
    550:
      id: 'start_referential_message'
      doc: 'A Start Referential message marks the beginning of the broadcast of the reference data.'
    551:
      id: 'end_referential_message'
      doc: 'An End Referential message marks the end of the broadcast of the reference data.'
    555:
      id: 'referential_message'
      doc: 'A Referential message carries the characteristics of an instrument, including its standard identifiers, trading parameters and reference prices.'
    220:
      id: 'trade_creation_message'
      doc: 'A Trade Creation message announces a trade that has just been created in the trading engine.'
    221:
      id: 'trade_cancellation_message'
      doc: 'A Trade Cancellation message announces the cancellation of a trade previously published.'
    240:
      id: 'trade_full_information_message'
      doc: 'A Trade Full Information message carries a trade along with the cumulated statistics of the instrument for the trading day.'
    241:
      id: 'price_update_message'
      doc: 'A Price Update message updates the statistics of an instrument without carrying a new trade.'
    245:
      id: 'auction_summary_message'
      doc: 'An Auction Summary message summarises the trades resulting from an auction.'
    247:
      id: 'vwap_closing_price_message'
      doc: 'A VWAP - Closing Price message contains the real time Volume-Weighted Average Price for an instrument together with the current closing price. This message is used exclusively at Qatar Exchange.'
    140:
      id: 'quotes_message'
      doc: 'A Quotes message carries the best limits of the order book for an instrument.'
    230:
      id: 'order_update_market_sheet_message'
      doc: 'An Order Update message carries a single order of the market sheet, so that the order book of an instrument may be rebuilt and maintained.'
    231:
      id: 'orderbook_retransmission_delimiter_message'
      doc: 'An Orderbook Retransmission Delimiter message delimits the retransmission of a market sheet, so that the order book is cleaned before the orders that follow are applied.'
    542:
      id: 'real_time_index_message'
      doc: 'A Real Time Index message carries the current level of an index.'
    543:
      id: 'index_summary_message'
      doc: 'An Index Summary message gives the summary of an index for the trading day.'
    544:
      id: 'index_composition_message'
      doc: 'An Index Composition message transmits one instrument making up an index, its weight and its adjustment coefficient.'
    580:
      id: 'start_refresh_message'
      doc: 'A refresh cycle begins with a Start Refresh message on the multicast channels.'
    581:
      id: 'end_refresh_message'
      doc: 'A refresh cycle ends with an End Refresh message on the multicast channels.'
  order_entry_rejection:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x4e:
      id: 'order_entry_allowed'
      doc: 'Order Entry Allowed'
    0x59:
      id: 'order_entry_forbidden'
      doc: 'Order Entry Forbidden'
  instrument_state:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'auction'
      doc: 'Auction'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x43:
      id: 'closed'
      doc: 'Closed'
  instrument_trading_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
  halt_reason:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x52:
      id: 'halted_no_liquidity_provider'
      doc: 'Halted No Liquidity Provider'
    0x43:
      id: 'opening_price_outside_collars'
      doc: 'Opening Price Outside Collars'
    0x4d:
      id: 'manuel_halting_by_market_operations'
      doc: 'Manuel Halting By Market Operations'
  action_affecting_state:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x43:
      id: 'trading_on_the_instrument_at_the_opening_sent_before_o'
      doc: 'Trading On The Instrument At The Opening Sent Before O'
    0x44:
      id: 'cancelled_programmed_opening'
      doc: 'Cancelled Programmed Opening'
    0x4d:
      id: 'instrument_manually_halted_by_market_operations'
      doc: 'Instrument Manually Halted By Market Operations'
    0x4e:
      id: 'instrument_is_being_initialized_beginning_of_the_trading_day'
      doc: 'Instrument Is Being Initialized Beginning Of The Trading Day'
    0x4f:
      id: 'instrument_opened'
      doc: 'Instrument Opened'
    0x50:
      id: 'deferred_programmed_opening'
      doc: 'Deferred Programmed Opening'
    0x52:
      id: 'automatic_halting_at_the_class_auction'
      doc: 'Automatic Halting At The Class Auction'
  instrument_state_tcs:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x53:
      id: 'instrument_is_forbidden'
      doc: 'Instrument Is Forbidden'
    0x41:
      id: 'instrument_is_authorized'
      doc: 'Instrument Is Authorized'
  period_side:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'bid_only_period'
      doc: 'Bid Only Period'
    0x56:
      id: 'offer_only_period'
      doc: 'Offer Only Period'
  instrument_group_state:
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
    0x43:
      id: 'beginning_of_day_consultation'
      doc: 'Beginning Of Day Consultation'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'market_session'
      doc: 'Market Session'
    0x52:
      id: 'trading_at_last'
      doc: 'Trading At Last'
    0x4e:
      id: 'surveillance_intervention'
      doc: 'Surveillance Intervention'
    0x46:
      id: 'end_of_day_inquiry'
      doc: 'End Of Day Inquiry'
    0x5a:
      id: 'interrupted'
      doc: 'Interrupted'
    0x49:
      id: 'forbidden'
      doc: 'Forbidden'
  session_type:
    0x45:
      id: 'early'
      doc: 'Early'
    0x43:
      id: 'core_session'
      doc: 'Core Session'
    0x4c:
      id: 'late'
      doc: 'Late'
  priority_indicator:
    0x4f:
      id: 'urgent_message'
      doc: 'Urgent Message'
    0x4e:
      id: 'non_urgent_message'
      doc: 'Non Urgent Message'
  type_of_message:
    0x42:
      id: 'market_information_contents'
      doc: 'Market Information Contents'
    0x54:
      id: 'technical_information'
      doc: 'Technical Information'
    0x52:
      id: 'market_and_technical_information'
      doc: 'Market And Technical Information'
  collar_type:
    0x44:
      id: 'dynamic_collars'
      doc: 'Dynamic Collars'
    0x53:
      id: 'static_thresholds'
      doc: 'Static Thresholds'
  period_indicator:
    0x4d:
      id: 'morning_effective_for_the_current_day'
      doc: 'Morning Effective For The Current Day'
    0x45:
      id: 'evening_effective_for_the_next_trading_day'
      doc: 'Evening Effective For The Next Trading Day'
  instrument_category:
    0x41:
      id: 'stock'
      doc: 'Stock'
    0x4f:
      id: 'bond'
      doc: 'Bond'
    0x57:
      id: 'warrant_and_certificate'
      doc: 'Warrant And Certificate'
    0x54:
      id: 'tracker'
      doc: 'Tracker'
    0x44:
      id: 'miscellaneous'
      doc: 'Miscellaneous'
  type_of_derivatives:
    0x31:
      id: 'inav_indicative_net_asset_value_for_etf_exchange_traded'
      doc: 'Inav Indicative Net Asset Value For Etf Exchange Traded'
    0x34:
      id: 'supports_short_terms_options'
      doc: 'Supports Short Terms Options'
    0x36:
      id: 'supports_long_term_options'
      doc: 'Supports Long Term Options'
    0x39:
      id: 'no_field'
      doc: 'No'
  repo_indicator:
    0x30:
      id: 'instrument_neither_eligible_for_the_srd_nor_eligible_for_the_loan'
      doc: 'Instrument Neither Eligible For The Srd Nor Eligible For The Loan'
    0x31:
      id: 'instrument_eligible_for_the_srd_and_for_the_loan_and_lending'
      doc: 'Instrument Eligible For The Srd And For The Loan And Lending'
    0x32:
      id: 'instrument_eligible_for_the_srd_but_not_for_the_loan_and_lending'
      doc: 'Instrument Eligible For The Srd But Not For The Loan And Lending'
    0x33:
      id: 'instrument_eligible_for_the_loan_and_lending_market_but_not_for_the'
      doc: 'Instrument Eligible For The Loan And Lending Market But Not For The'
    0x38:
      id: 'non_significant'
      doc: 'Non Significant'
  type_of_unit_exp:
    1:
      id: 'in_units'
      doc: 'In Units'
    2:
      id: 'as_a_of_nominal'
      doc: 'As A Of Nominal'
    3:
      id: 'as_a_of_nominal_including_accrued_interest'
      doc: 'As A Of Nominal Including Accrued Interest'
    8:
      id: 'in_kilograms'
      doc: 'In Kilograms'
    9:
      id: 'in_ounces'
      doc: 'In Ounces'
  market_indicator:
    0:
      id: 'not_used'
      doc: 'Not Used'
    1:
      id: 'cash'
      doc: 'Cash'
    9:
      id: 'not_defined'
      doc: 'Not Defined'
  tax_code:
    0:
      id: 'not_eligible_to_pea'
      doc: 'Not Eligible To Pea'
    3:
      id: 'eligible_to_pea'
      doc: 'Eligible To Pea'
    9:
      id: 'not_provided'
      doc: 'Not Provided'
  algo:
    0x46:
      id: 'fifo'
      doc: 'Fifo'
    0x4f:
      id: 'fifo_origin'
      doc: 'Fifo Origin'
  small_trade_indicator:
    0x31:
      id: 'not_a_small_trade'
      doc: 'Not A Small Trade'
    0x32:
      id: 'small_trade'
      doc: 'Small Trade'
  trad_cond_2:
    0x30:
      id: 'not_last_of_a_series_of_trades_at_the_same_price'
      doc: 'Not Last Of A Series Of Trades At The Same Price'
    0x31:
      id: 'last_of_a_series_of_trade_at_the_same_price'
      doc: 'Last Of A Series Of Trade At The Same Price'
  trad_cond_3:
    0x30:
      id: 'trade_does_not_stem_from_a_cross_order'
      doc: 'Trade Does Not Stem From A Cross Order'
    0x31:
      id: 'trade_stems_from_a_cross_order'
      doc: 'Trade Stems From A Cross Order'
    0x34:
      id: 'valuation_trade'
      doc: 'Valuation Trade'
  trade_origin:
    0x42:
      id: 'orders_from_the_book'
      doc: 'Orders From The Book'
    0x4f:
      id: 'block_trade'
      doc: 'Block Trade'
  opening_trade_indicator:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'core_session'
      doc: 'Core Session'
  tick_direction:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
    0x30:
      id: 'no_variation_or_data_field_not_significant'
      doc: 'No Variation Or Data Field Not Significant'
  type_of_price:
    0:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
    2:
      id: 'ask_price'
      doc: 'Ask Price'
    3:
      id: 'bid_price'
      doc: 'Bid Price'
    4:
      id: 'first_traded_price_one_quotation_only'
      doc: 'First Traded Price One Quotation Only'
    5:
      id: 'market_imbalance_ask_price'
      doc: 'Market Imbalance Ask Price'
    6:
      id: 'market_imbalance_bid_price'
      doc: 'Market Imbalance Bid Price'
    30:
      id: 'change_of_first_price'
      doc: 'Change Of First Price'
    31:
      id: 'new_high_price'
      doc: 'New High Price'
    32:
      id: 'new_low_price'
      doc: 'New Low Price'
    33:
      id: 'new_last_price'
      doc: 'New Last Price'
    34:
      id: 'new_previous_days_closing_price'
      doc: 'New Previous Days Closing Price'
    41:
      id: 'warrant_opening_indicative_value'
      doc: 'Warrant Opening Indicative Value'
    42:
      id: 'warrant_closing_indicative_value'
      doc: 'Warrant Closing Indicative Value'
    51:
      id: 'indicative_price'
      doc: 'Indicative Price'
  type_of_last_price:
    4:
      id: 'first_traded_price'
      doc: 'First Traded Price'
    7:
      id: 'n_traded_price_resume_after_reservation'
      doc: 'N Traded Price Resume After Reservation'
  instrument_valuation_price:
    0x30:
      id: 'not_a_valuation_price'
      doc: 'Not A Valuation Price'
    0x31:
      id: 'valuation_price'
      doc: 'Valuation Price'
  type_of_ask_price:
    0:
      id: 'limit_order'
      doc: 'Limit Order'
    1:
      id: 'market_order'
      doc: 'Market Order'
    2:
      id: 'at_opening_order_nsc_only'
      doc: 'At Opening Order Nsc Only'
  type_of_bid_price:
    0:
      id: 'limit_order'
      doc: 'Limit Order'
    1:
      id: 'market_order'
      doc: 'Market Order'
    2:
      id: 'at_opening_order_nsc_only'
      doc: 'At Opening Order Nsc Only'
  quote_condition:
    0x30:
      id: 'no_liquidity_provider_lp'
      doc: 'No Liquidity Provider Lp'
    0x31:
      id: 'lp_only_on_ask_side'
      doc: 'Lp Only On Ask Side'
    0x32:
      id: 'lp_only_on_bid_side'
      doc: 'Lp Only On Bid Side'
    0x33:
      id: 'lp_on_ask_and_bid_sides'
      doc: 'Lp On Ask And Bid Sides'
  order_type:
    0x31:
      id: 'market_order'
      doc: 'Market Order'
    0x32:
      id: 'limit_order'
      doc: 'Limit Order'
    0x4b:
      id: 'market_to_limit_order'
      doc: 'Market To Limit Order'
    0x50:
      id: 'peg_order'
      doc: 'Peg Order'
  action_type:
    0x41:
      id: 'new_order'
      doc: 'New Order'
    0x44:
      id: 'deletion_of_order_identified_by_order_id'
      doc: 'Deletion Of Order Identified By Order Id'
    0x50:
      id: 'deletion_of_order_identified_by_order_id_and_all_preceding_orders'
      doc: 'Deletion Of Order Identified By Order Id And All Preceding Orders'
    0x46:
      id: 'deletion_of_all_orders_for_the_given_instrument_depending_on_the'
      doc: 'Deletion Of All Orders For The Given Instrument Depending On The'
    0x59:
      id: 'retransmission_of_all_orders_for_the_given_instrument'
      doc: 'Retransmission Of All Orders For The Given Instrument'
  rebroadcast_indicator:
    0x30:
      id: 'current_day'
      doc: 'Current Day'
    0x31:
      id: 'previous_day'
      doc: 'Previous Day'

