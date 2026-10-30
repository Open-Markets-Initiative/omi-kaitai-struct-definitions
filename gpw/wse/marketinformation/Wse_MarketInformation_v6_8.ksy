# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse MarketInformation Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Market Information
#   Encoding: Exchange Data Publisher
#   Version: 6.8
#   Date: 02/11/2020
#   Specification: WSE_CDE_XDP_Message_Specifications_v_68.pdf
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
  id: gpw_wse_marketinformation_xdp_v6_8
  title: Gpw Wse MarketInformation Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Market Information Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message_buffer
    type: message_buffer_struct
    size-eos: true
    doc: 'The packet''s message area: the messages it counts, or one ZliB block holding them'

types:
  packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the packet including the 16 byte packet header'
      - id: packet_type
        type: u2
        enum: packet_type
        doc: 'Identifier for the type of data contained in the packet. Section 1.1 states one value, 501 for Market Data messages, for every feed the document specifies'
      - id: packet_sequence_number
        type: u4
        doc: 'The packet sequence number, unique for each broadcast stream and used for gap detection. It increases serially and monotonically and is reset to 1 at the beginning of each trading day. It is unique for packets containing market data only, and heartbeats inherit it from the last market data packet or packet sequence number reset packet'
      - id: send_time
        type: u4
        doc: 'Timestamp in millisecond indicating the packet broadcast time. The number represents the number of milliseconds since midnight of the last Sunday 00:00 UTC, a weekly epoch no Epoch trait represents, so the field carries no epoch and a reader resolves the absolute time against the Sunday preceding the capture'
      - id: service_id
        type: u2
        doc: 'Numeric value identifying the broadcast stream. Section 1.1 states that the possible values are described in the XDP CDE Configuration document, a companion this specification does not reproduce, so no value set is declared here'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Indicates delivery method, and a client reads it to determine whether the packet is ZliB compressed'
      - id: number_msg_entries
        type: u1
        doc: 'The number of messages that are contained within the packet'
  message_buffer_struct:
    seq:
      - id: message
        type: message
        repeat: expr
        repeat-expr: _root.packet_header.number_msg_entries
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::class_state_change_message': class_state_change_message
            'message_type::mail_message': mail_message
            'message_type::collars_message': collars_message
            'message_type::session_timetable_message': session_timetable_message
            'message_type::start_referential_message': start_referential_message
            'message_type::end_referential_message': end_referential_message
            'message_type::referential_message': referential_message
            'message_type::session_summary_message': session_summary_message
            'message_type::instrument_state_change_message': instrument_state_change_message
            'message_type::indicative_matching_price_message': indicative_matching_price_message
            'message_type::short_sale_change_message': short_sale_change_message
            'message_type::generic_wse_message': generic_wse_message
            'message_type::open_position_message': open_position_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class Identification'
      - id: instrument_group_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: session_type
        type: u1
        enum: session_type
        doc: 'Market Session'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: class_state
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class status representing the current trading market phase for instruments belonging to that class and whose status is inherited'
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: scope
        type: str
        size: 1
        encoding: ASCII
        doc: 'Scope'
      - id: title
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Title'
      - id: text_ascii_str_1000
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text'
      - id: reserved_3
        size: 3
        doc: 'For future use'
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: high_scale_code
        type: u1
        doc: 'To be combined with HighCollar'
      - id: low_scale_code
        type: u1
        doc: 'To be combined with LowCollar'
      - id: collar_type
        type: u1
        enum: collar_type
        doc: 'Defines the type of collars'
      - id: reserved_3
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class Identification'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: class_phase_number
        type: u2
        doc: 'Indicates the number of class phases'
      - id: class_phase
        type: class_phase
        repeat: expr
        repeat-expr: 15
        doc: 'A class phase of the session timetable, the start time of the phase and the phase itself, repeated 15 times'
  class_phase:
    seq:
      - id: class_state_time
        type: hhmm_ascii_time
        doc: 'Indicates the start time of the class phase, format HHMM'
      - id: class_state
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class status representing the current trading market phase for instruments belonging to that class and whose status is inherited'
  start_referential_message:
    seq:
      - id: indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field indicates the start of the Referential flow'
      - id: reserved_3
        size: 3
        doc: 'For future use'
  end_referential_message:
    seq:
      - id: indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field indicates the start of the Referential flow'
      - id: reserved_3
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: prev_volume_traded
        type: u4
        doc: 'Not used'
      - id: reserved_4
        size: 4
        doc: 'For future use'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: stock_exchange_code
        type: u2
        enum: stock_exchange_code
        doc: 'Indicates the Market Place'
      - id: type_of_instrument_binary_int_2
        type: u2
        doc: 'Type of instrument'
      - id: event_date
        type: yyyymmdd_ascii_date
        doc: 'Date of the last modification of the characteristics of the instrument except the following ones (which are modified every day)'
      - id: instrument_name
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument Name For instrument others than SHARES: Contains a short instrument name (Formally known as mnemonic)'
      - id: period_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: type_of_market_admission
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: issuing_country_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Country code of location for the corporate headquarters of the company that issued the instrument'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the currency in which the instrument is traded'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class Identification'
      - id: instrument_category
        type: u1
        enum: instrument_category
        doc: 'Indicates to which category, the security belongs'
      - id: instrument_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code, International Securities Identification Number, according to the ISO-6166'
      - id: date_of_last_trade
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Available'
      - id: underlying_repo_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying security (security used in the loan quotation system) for loan contracts at given value on centralized lending market'
      - id: expiry_date
        type: yyyymmdd_ascii_date
        doc: 'Instrument expiry date'
      - id: first_settlement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Represents the first possible settlement date for a given instrument with the instrument''s depository'
      - id: type_of_derivatives
        type: u1
        enum: type_of_derivatives
        doc: 'Type of derivative instrument associated to the security'
      - id: bic_depositary
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the depository organization for the shares of an instrument, or when the same organization manages several systems, this item identifies the relevant settlement system for settling trades on a given listed security'
      - id: icb
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies for a listed instrument, the economic subsector of the issuing company in the ICB (Industry Classification Benchmark) classification'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the market to which an instrument belongs to by its MIC (Market Identification code), according to ISO 10383'
      - id: underlying_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gives the ISIN Code of a warrant or a derivatives instrument'
      - id: depositary_list
        type: depositary_list
        repeat: expr
        repeat-expr: 5
        doc: 'The possible main depository organizations of an instrument. Section 1.2.10.3 gives the entry width, max 5 characters padded with zeros, and the field width, 25 bytes, so the run is five entries; the document does not state the count in words. Used by the clearing house to determine the relevant system for settling trades'
      - id: main_depositary
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the default (or main) depository organisation of the instrument used by priority for the settlement (e.g.: multi-listed instruments which have several depositories)'
      - id: type_of_corporate_event
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the last type of corporate event that has occurred on an instrument, such as detachment of rights, or of coupons'
      - id: time_lag_euronext_utc
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: time_lag_mi_fid_reg_utc
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: cfi
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Classification code of a financial instrument defined by the ISO- 10962 standard'
      - id: second_reserved_4
        size: 4
        doc: 'For future use'
      - id: index_set_of_var_price_tick
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'When the instrument''s tick is defined via a Variable Tick Table: The key for the variable price tick table consists of two data items [the index for a set of variable price ticks, the lowest value in a range of prices]. The index data item refers to a set of lines in that table which make it possible to determine the price tick for an instrument, based on the price range in which a given price for the instrument falls (i.e'
      - id: market_feed_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Available'
      - id: mic_list
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: industry_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: industry_text
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: financial_market_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Used'
      - id: us_indicators
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: reserved_2
        size: 2
        doc: 'For future use'
      - id: prev_day_capital_traded
        type: u8
        doc: 'Not used'
      - id: lot_size
        type: u8
        doc: 'Expressed in number of shares or in an amount or a volume of the capital, of the lot size'
      - id: number_instrument_circ
        type: u8
        doc: 'Number of shares issued/bonds outstanding after payments'
      - id: shares_out
        type: u8
        doc: 'For BondSpot ONLY: Number of quoted instrument For WSE: filled with zero'
      - id: auth_shares
        type: u8
        doc: 'Not used'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indication as to whether the price and the strike price is expressed in monetary value, in percentage or in yield Possible values: - MONE: monetary value'
      - id: repo_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: notional_amount
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Nominal amount or notional amount'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the notional is denominated as defined by ISO 4217'
      - id: last_adj_price_scale_code
        type: u1
        doc: 'To be combined with LastAdjPrice'
      - id: market_indicator
        type: u1
        enum: market_indicator
        doc: 'Indicates the market regulations governing the market on which the security is traded'
      - id: prev_day_capital_traded_scale_code
        type: u1
        doc: 'Not used'
      - id: tax_code
        type: u1
        doc: 'Not used'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: lot_size_scale_code
        type: u1
        doc: 'To be combined with LotSize'
      - id: second_reserved_1
        size: 1
        doc: 'For future use'
      - id: mnemo
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Mnemonic code of the instrument'
      - id: trading_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'For WSE: Trading code of the instrument'
      - id: third_reserved_4
        size: 4
        doc: 'For future use'
      - id: strike_price
        type: u4
        doc: 'The specified price of an option contract at which the contract may be exercised, whereby a call option buyer can buy the underlying or a put option buyer can sell the underlying'
      - id: strike_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the currency in which the Warrant Strike Price is expressed'
      - id: strike_scale_code
        type: u1
        doc: 'To be combined with StrikePrice'
      - id: currency_coef
        type: u4
        doc: 'Change ratio coefficient of currency applied to instrument: Used in conjunction with one of the change rate indicators in order to apply this coefficient to a currency among two available currencies defined for the instrument: - Trading currency - Currency code of strike price for Derivative Instrument The currency to which this coefficient will be applied depends on just one of the two values set to the related indicators (defined below in the integrity constraints)'
      - id: currency_coef_scale_code
        type: u1
        doc: 'To be combined with CurrencyCoef Not used'
      - id: trading_currency_indicator
        type: u1
        doc: 'Change rate indicator for currency of Instrument Traded Price'
      - id: strike_currency_indicator
        type: u1
        doc: 'Change rate indicator for currency of the strike price Indicates if the change rate will be applied to the currency defined for strike prices of the instrument'
      - id: market_segment
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Segment'
      - id: algo
        type: u1
        enum: algo
        doc: 'Indicates which algorithm is used'
      - id: local_name
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuing company short name'
      - id: block_size
        type: u4
        doc: 'Size of a normal block'
      - id: ss_market_maker
        type: u1
        enum: ss_market_maker
        doc: 'Field should be ignored Short sale eligibility for a capacity of a market maker'
      - id: ss_non_market_maker
        type: u1
        enum: ss_non_market_maker
        doc: 'Field should be ignored Short sale eligibility for a capacity different from market maker'
      - id: settlement_delay
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlement delay for the trades'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Indicates the type of an option only (otherwise left blank i.e'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the type of delivery for a derivatives instrument only (otherwise left blank i.e'
      - id: exercise_type
        type: u1
        enum: exercise_type
        doc: 'Indicates the type of exercise for an option only (otherwise left blank i.e'
      - id: multiplier_scale_code
        type: u1
        doc: 'To be combined with Multiplier'
      - id: warrant_threshold_min_scale_code
        type: u1
        doc: 'To be combined with WarrantThresholdMin'
      - id: warrant_threshold_max_scale_code
        type: u1
        doc: 'To be combined with WarrantThresholdMax'
      - id: second_reserved_2
        size: 2
        doc: 'For future use'
      - id: warrant_threshold_min
        type: u4
        doc: 'Minimum threshold for the warrant underlying'
      - id: warrant_threshold_max
        type: u4
        doc: 'Maximum threshold for the warrant underlying'
      - id: min_quantity
        type: u4
        doc: 'Minimum quantity allowed for orders on that instrument'
      - id: max_quantity
        type: u4
        doc: 'Maximum quantity allowed for orders on that instrument'
      - id: multiplier
        type: u4
        doc: 'Multiplier'
      - id: fourth_reserved_4
        size: 4
        doc: 'For future use'
      - id: max_value
        type: u8
        doc: 'Maximum order value allowed for orders on that instrument'
  depositary_list:
    seq:
      - id: depositary
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A depository organization of the instrument, 5 characters padded with zeros. The document gives Null - Not significant for an entry that is not populated, without stating its form on the wire, so no sentinel is declared. Nullable, Not Significant = 0'
  session_summary_message:
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
      - id: date_binary_int_4
        type: yyyymmdd_date
        doc: 'Stock Exchange date (YYYYMMDD)'
      - id: multiplier
        type: u4
        doc: 'Multiplier'
      - id: accumulated_interest
        type: u4
        doc: 'Accumulated interest on the bonds or for mortgage-backed bonds on the day of settling the transaction'
      - id: opening_price
        type: u4
        doc: 'Single-price quotation: The first single-price defined at the fixing during a particular stock exchange session'
      - id: maximum_price
        type: u4
        doc: 'Single-price quotation: The maximum single-price during the current stock exchange session'
      - id: minimum_price
        type: u4
        doc: 'Single-price quotation: The minimum single-price during the current session'
      - id: closing_price
        type: u4
        doc: 'Single-price quotation: Single-price determined at the last fixing during a particular session'
      - id: implied_volatility
        type: u4
        doc: 'Implied volatility of WIG 20 index calculated on the basis of the price of the last transaction at the session for options on WIG 20 index with the use of Black-Scholes option pricing model according to algorithm worked out by the WSE, which is available on the website: www.opcje.gpw.pl'
      - id: average_weighted_price
        type: u4
        doc: 'The average weighted by the trading volume price of concluding the transaction for a particular instrument during a particular stock exchange session'
      - id: reference_price
        type: u4
        doc: 'The reference price valid for the current session'
      - id: pct_change_price
        type: u4
        doc: 'Percentage change of the instrument closing price at the current session in relation to the reference price'
      - id: dividend_rate
        type: u4
        doc: 'Dividend rate for the company is given on the basis of dividends paid by companies being the base instrument for futures and options'
      - id: settlement_price
        type: u4
        doc: 'The price defined according to the trading conditions depending on the type of instrument'
      - id: settlement_value
        type: u4
        doc: 'The price defined depending on the type of instrument'
      - id: reserved_4
        size: 4
        doc: 'For future use'
      - id: open_positions
        type: u4
        doc: 'Number of open positions after the end of the session'
      - id: trading_volume
        type: u4
        doc: 'Accumulated trading volume of all transactions concluded on a particular instrument during the current session'
      - id: transactions_number
        type: u4
        doc: 'The total number of transactions concluded on a particular instrument during the current market session'
      - id: trading_value
        type: u8
        doc: 'Accumulated value of all transactions concluded on a particular instrument during the current stock exchange session'
      - id: currency_price
        type: u4
        doc: 'The field contains the currency price from the Stock Exchange trading session day'
      - id: delta
        type: u4
        doc: 'Value of Delta indicator from the current session'
      - id: gamma
        type: u4
        doc: 'Value of gamma indicator from the current session'
      - id: rho
        type: u4
        doc: 'Value of rho indicator from the current session'
      - id: theta
        type: u4
        doc: 'Value of theta indicator from the current session'
      - id: vega
        type: u4
        doc: 'Value of vega indicator from the current session'
      - id: end_trading
        type: yyyymmdd_date
        doc: 'End of trading date (YYYYMMDD)'
      - id: number_of_instruments
        type: u4
        doc: 'Number of instruments admitted to trading For European type of warrants, the number of warrants in trade is equal to the number of issued warrants, while for the American type of warrants, the number of warrants in trade is equal to the number of issued warrants reduced by the number of executed warrants'
      - id: trading_value_currency
        type: u8
        doc: 'The field comprises the trading value expressed in trading currency'
      - id: interest_rate
        type: u4
        doc: 'Interest rate is determined on the basis of WIBOR/WIBID rates for each expiration date of options and futures'
      - id: volatility
        type: u4
        doc: 'Volatility to be calculated is based on the implied volatility (provided in field ImpliedVolatility) according to algorithm worked out by the WSE, which is available on the website: www.opcje.gpw.pl'
      - id: strike_price
        type: u4
        doc: 'The specified price of an option contract at which the contract may be exercised, whereby a call option buyer can buy the underlying or a put option buyer can sell the underlying'
      - id: short_selling_trades_number
        type: u4
        doc: 'Field should be ignored'
      - id: volume_short_selling_trades
        type: u4
        doc: 'Field should be ignored'
      - id: value_short_selling_trades
        type: u4
        doc: 'Field should be ignored'
      - id: last_trade_date
        type: yyyymmdd_date
        doc: 'The date of execution of the last trade for the given instrument (YYYYMMDD)'
      - id: last_trade_price
        type: u4
        doc: 'The price of the last trade for given instrument'
      - id: block_trades_number
        type: u4
        doc: 'The total number of block trades concluded on a particular instrument during the current trading session'
      - id: volume_block_trades
        type: u4
        doc: 'The total turnover volume of block trades concluded on a particular instrument during the current trading session'
      - id: value_block_trades
        type: u4
        doc: 'The total turnover value of block trades concluded on a particular instrument during the current trading session'
      - id: vwap_blocktrade
        type: u4
        doc: 'Volume weighted average price of block trades for a particular instrument during a particular trading session, calculated according the following algorithm: ( TCS trade price * TCS trade volume ) /  (TCS trade volume) If no block trades were concluded during the trading session, the field is completed with zeros'
      - id: maximum_block_price
        type: u4
        doc: 'Maximum price of block trades in the instrument during the current trading session'
      - id: minimum_block_price
        type: u4
        doc: 'Minimum price of block trades in the instrument during the current trading session'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: multiplier_scale_code
        type: u1
        doc: 'To be combined with Multiplier'
      - id: accumulated_interest_scale_code
        type: u1
        doc: 'Applicable to the accumulated interest'
      - id: opening_price_scale_code
        type: u1
        doc: 'Applicable to the opening price'
      - id: maximum_price_scale_code
        type: u1
        doc: 'Applicable to the maximum price'
      - id: minimum_price_scale_code
        type: u1
        doc: 'Applicable to the minimum price'
      - id: closing_price_scale_code
        type: u1
        doc: 'Applicable to the closing price'
      - id: implied_volatility_scale_code
        type: u1
        doc: 'Applicable to the implied volatility'
      - id: average_weighted_price_scale_code
        type: u1
        doc: 'Applicable to the average weighted price'
      - id: reference_price_scale_code
        type: u1
        doc: 'Applicable to the reference price'
      - id: pct_change_price_scale_code
        type: u1
        doc: 'Applicable to the percentage change price'
      - id: dividend_rate_scale_code
        type: u1
        doc: 'Applicable to the dividend rate'
      - id: settlement_price_scale_code
        type: u1
        doc: 'Applicable to the settlement price'
      - id: settlement_value_scale_code
        type: u1
        doc: 'Applicable to the settlement value'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: trading_value_scale_code
        type: u1
        doc: 'Applicable to the trading value'
      - id: currency_price_scale_code
        type: u1
        doc: 'Applicable to the currency price'
      - id: delta_scale_code
        type: u1
        doc: 'Applicable to the delta'
      - id: gamma_scale_code
        type: u1
        doc: 'Applicable to the gamma'
      - id: rho_scale_code
        type: u1
        doc: 'Applicable to the rho'
      - id: theta_scale_code
        type: u1
        doc: 'Applicable to the theta'
      - id: vega_scale_code
        type: u1
        doc: 'Applicable to the vega'
      - id: trading_value_currency_scale_code
        type: u1
        doc: 'Applicable to the trading value'
      - id: interest_rate_scale_code
        type: u1
        doc: 'Applicable to the interest rate'
      - id: volatility_scale_code
        type: u1
        doc: 'Applicable to the volatility'
      - id: strike_price_scale_code
        type: u1
        doc: 'Applicable to the strike price'
      - id: value_short_selling_trades_scale_code
        type: u1
        doc: 'Field should be ignored'
      - id: last_trade_price_scale_code
        type: u1
        doc: 'Applicable to the last trade price'
      - id: value_block_trades_scale_code
        type: u1
        doc: 'Applicable to the value of the block trades'
      - id: vwap_blocktrade_scale_code
        type: u1
        doc: 'Applicable to the VWAP block trade'
      - id: maximum_block_price_scale_code
        type: u1
        doc: 'Applicable to the maximum block price'
      - id: minimum_block_price_scale_code
        type: u1
        doc: 'Applicable to the minimum block price'
      - id: status_indicator
        type: u1
        enum: status_indicator
        doc: 'Defines the status of the instrument at the end of the stock exchange session'
      - id: sector
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sector of the economy that the company belongs to'
      - id: market
        type: u1
        enum: market
        doc: 'Defines the market the instrument belongs to'
      - id: second_reserved_1
        size: 1
        doc: 'For future use'
      - id: short_sale
        type: str
        size: 1
        encoding: ASCII
        doc: 'Field should be ignored'
      - id: marker_pct_change_price
        type: u1
        enum: marker_pct_change_price
        doc: 'The field contains the market of the percentage change of the instrument closing price from the current session in relation to the reference price'
      - id: symbol_delta
        type: u1
        enum: symbol_delta
        doc: 'The field contains a symbol of Delta indicator from the current session'
      - id: symbol_gamma
        type: u1
        enum: symbol_gamma
        doc: 'The field contains a symbol of Gamma indicator from the current session'
      - id: symbol_rho
        type: u1
        enum: symbol_rho
        doc: 'The field contains a symbol of Rho indicator from the current session'
      - id: symbol_theta
        type: u1
        enum: symbol_theta
        doc: 'The field contains a symbol of Theta indicator from the current session'
      - id: symbol_vega
        type: u1
        enum: symbol_vega
        doc: 'The field contains a symbol of Vega indicator from the current session'
      - id: third_reserved_1
        size: 1
        doc: 'For future use'
      - id: fourth_reserved_1
        size: 1
        doc: 'For future use'
      - id: fifth_reserved_1
        size: 1
        doc: 'For future use'
      - id: sixth_reserved_1
        size: 1
        doc: 'For future use'
      - id: seventh_reserved_1
        size: 1
        doc: 'For future use'
      - id: eighth_reserved_1
        size: 1
        doc: 'For future use'
      - id: segment
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Informs in which segment the instrument is traded'
      - id: lower_liquidity
        type: str
        size: 1
        encoding: ASCII
        doc: 'The field informs if the company was qualified to Lower Liquidity Space'
      - id: dividend
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field informs that the instruments are traded the first time after determining the right to dividend'
      - id: subscription_right
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field informs that the securities are traded the first time after determining the subscription right'
      - id: split
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field informs that the securities are traded the first time after the change of the nominal value of shares'
      - id: interim_dividend_right
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field informs that the shares are traded the first time after determining the interim dividend rights'
      - id: quotation_system
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The field informing about the system of listing the instrument'
      - id: liquidity_support_pge
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The field informs if the company entered to Liquidity Support Programme'
      - id: ninth_reserved_1
        size: 1
        doc: 'For future use'
  instrument_state_change_message:
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: reserved_2
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
        doc: 'Instrument opening (unhalting) time that has been programmed by the Market Operation Team'
      - id: order_entry_rejection
        type: u1
        enum: order_entry_rejection
        doc: 'Indicates whether order entry is allowed or forbidden. Nullable, Not Provided = 0'
      - id: instrument_state
        type: u1
        enum: instrument_state
        doc: 'Indicates the state of the instrument'
      - id: instrument_trading_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Indicates the origin of halting for an instrument'
      - id: action_affecting_state
        type: u1
        enum: action_affecting_state
        doc: 'Code indicating the event that caused a change in the instrument state'
      - id: instrument_state_tcs
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: period_side
        type: u1
        enum: period_side
        doc: 'Indicates the side for an instrument beginning or ending a Bid only or Offer only situation'
      - id: reserved_1
        size: 1
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
        doc: 'Percentage variation of the last IMP against the previous day''s reference price for the stock concerned, ie the last known (signed) price can be the last adjusted closing price or the last price indication (valuation trade).(To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: price_scale_code
        type: u1
        doc: 'To be combined with IMPrice'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with Variation'
      - id: im_volume
        type: u4
        doc: 'Indicative Matching Volume: Volume that would be exchanged if Auction occurred at this moment'
  short_sale_change_message:
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
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: text_ascii_ch_100
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text'
      - id: authority
        type: u1
        enum: authority
        doc: 'Indicates the authority which required the short sale change'
      - id: ss_market_maker
        type: u1
        enum: ss_market_maker
        doc: 'Field should be ignored Short sale eligibility for a capacity of a market maker'
      - id: ss_non_market_maker
        type: u1
        enum: ss_non_market_maker
        doc: 'Field should be ignored Short sale eligibility for a capacity different from market maker'
      - id: reserved_3
        size: 3
        doc: 'For future use'
  generic_wse_message:
    seq:
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: source_data
        type: str
        size: 1
        encoding: ASCII
        doc: 'Source of Data: ''1'' - UTP Cash ''2'' - UTP Derivatives ''3'' - Indexator ''4'' -BondSpot ''5'' – other ''space'' - not applicable'
      - id: internal_msg_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field specifies the internal message type'
      - id: event_date
        type: yyyymmdd_ascii_date
        doc: 'Date of the last modification of the characteristics of the instrument except the following ones (which are modified every day)'
      - id: instrument_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'WSE: TradingCode BS: InstrumentCode ''Space'' – not applicable'
      - id: instrument_group_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class Identification'
      - id: msg_type_indicator
        type: u1
        enum: msg_type_indicator
        doc: 'Field defines the character or nature of the message being sent'
      - id: language_version
        type: u1
        enum: language_version
        doc: 'Field defines the language of the contents of the message'
      - id: type_off_recipient
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field defines the class of the recipient of a message being sent This field assumes one of the below specified values: ''D'' – distributors of information ''M'' – exchange members'
      - id: msg_serial_num
        type: str
        size: 1
        encoding: ASCII
        doc: 'The message serial number within the framework of the whole given message based on InternalMsgType'
      - id: body_message
        type:
          switch-on: internal_msg_type
          cases:
            '"02"': treasury_bond_futures_data
            '"03"': kid
            '"04"': market_conditions
            '"05"': market_conditions
  treasury_bond_futures_data:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Treasury Bond Future ISIN Code'
      - id: date_of_first_quotation
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date of first quotation of given futures indicated in field ISIN Code'
      - id: short_name
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Treasury Bond Future short name'
      - id: date_ascii_str_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Start date'
      - id: underlying_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gives the ISIN Code of a warrant or a derivatives instrument'
      - id: treasury_bond_1_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of (1) Treasury Bond series included in the bond basket'
      - id: conversion_coefficient_factor_1
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Conversion coefficient value for (1) Treasury Bonds series, a numeric value with a fixed decimal places of 6'
      - id: treasury_bond_2_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of (2) Treasury Bond series included in the bond basket'
      - id: conversion_coefficient_factor_2
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Conversion coefficient value for (2) Treasury Bonds series, a numeric value with a fixed decimal places of 6'
      - id: treasury_bond_3_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of (3) Treasury Bond series included in the bond basket'
      - id: conversion_coefficient_factor_3
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Conversion coefficient value for (3) Treasury Bonds series, a numeric value with a fixed decimal places of 6'
      - id: treasury_bond_4_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of (4) Treasury Bond series included in the bond basket'
      - id: conversion_coefficient_factor_4
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Conversion coefficient value for (4) Treasury Bonds series, a numeric value with a fixed decimal places of 6'
      - id: treasury_bond_5_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of (5) Treasury Bond series included in the bond basket'
      - id: conversion_coefficient_factor_5
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Conversion coefficient value for (5) Treasury Bonds series, a numeric value with a fixed decimal places of 6'
      - id: reserved_59
        size: 59
        doc: 'For future use'
  kid:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Treasury Bond Future ISIN Code'
      - id: type_of_instrument_ascii_str_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of instrument / Categorization code'
      - id: kid_version
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the version of KID'
      - id: kid_issue_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date of creation and first publication of KID for given instrument / Issue date'
      - id: value_at_risk
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value included in this field depends on the information delivered'
      - id: holding_period
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the PRIIPs recommended holding period'
      - id: priip_kid_url
        type: str
        size: 182
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the URL from which the KID can be retrieved, written PRIIP KID/url in the document'
  market_conditions:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Treasury Bond Future ISIN Code'
      - id: market_conditions_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the state of market conditions'
      - id: market_conditions_number
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique numeric and increasing identifier of Market Conditions during a day'
      - id: reserved_203
        size: 203
        doc: 'Filler'
  open_position_message:
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
      - id: trading_date
        type: yyyymmdd_ascii_date
        doc: 'Date of trading day (YYYYMMDD)'
      - id: open_position
        type: u4
        doc: 'Number of open positions'
      - id: transaction_number
        type: u4
        doc: 'Number of transactions when OpenPositionIndicator = 0'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: open_position_indicator
        type: u1
        enum: open_position_indicator
        doc: 'The field defines whether: -the NOP value being sent is a value calculated during the quotation based on the incoming TRANSACTION messages – and thus an estimated value -the NOP value being sent is the last on a given day -the value being sent is a verified value'
      - id: reserved_1
        size: 1
        doc: 'For future use'
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
  hhmm_ascii_time:
    seq:
      - id: text
        type: str
        size: 4
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
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
  packet_type:
    501:
      id: 'market_data_messages'
      doc: 'Market Data messages'
  delivery_flag:
    0:
      id: 'real_time_message_uncompressed'
      doc: 'Real Time message (Uncompressed)'
    2:
      id: 'retransmission_message_uncompressed'
      doc: 'Retransmission message (Uncompressed)'
    16:
      id: 'real_time_message_zlib_compressed'
      doc: 'Real Time message (ZliB Compressed)'
    17:
      id: 'refresh_message_zlib_compressed'
      doc: 'Refresh message (ZliB Compressed)'
    18:
      id: 'retransmission_message_compressed'
      doc: 'Retransmission message (Compressed)'
  message_type:
    516:
      id: 'class_state_change_message'
      doc: 'The Class State Change message indicates a change in the state of a class'
    523:
      id: 'mail_message'
      doc: 'This message supplies a part or a complete electronic message (E-mail), in order to inform members and rebroadcasting members about quotation conditions on a given listed instrument or a set of listed instruments or otherwise about a technical problem'
    537:
      id: 'collars_message'
      doc: 'A Collars message informs Clients of modifications in authorized price fluctuations for an instrument'
    539:
      id: 'session_timetable_message'
      doc: 'The session timetable message indicates the timetable listing all the states changes of a Class for the current trading day'
    550:
      id: 'start_referential_message'
      doc: 'The Start referential message is sent to signal the start of transmission of the Instrument Reference Data Flow'
    551:
      id: 'end_referential_message'
      doc: 'The End referential message is sent to signal the end of transmission of the Instrument Reference Data Flow'
    556:
      id: 'referential_message'
      doc: 'The referential message indicates the main characteristics of a listed instrument:  Characteristics of the instrument itself  Trading characteristics of the instrument  Previous trading day price'
    561:
      id: 'session_summary_message'
      doc: 'This message contains statistical data'
    505:
      id: 'instrument_state_change_message'
      doc: 'An ''Instrument State Change'' message is generated by the trading engines to announce a change in the state of an instrument'
    530:
      id: 'indicative_matching_price_message'
      doc: 'The Indicative matching price message indicates an instrument''s theoretical opening price (also known as an indicative opening price):  An IMP-message is sent if the indicative matching price or – volume varies'
    560:
      id: 'short_sale_change_message'
      doc: 'The Short Sale Change message indicates whether an instrument short sale is suspended or re-authorized'
    592:
      id: 'generic_wse_message'
      doc: 'This message is a free format message with a container of 250 bytes'
    595:
      id: 'open_position_message'
      doc: 'The Open Position message indicates the current number of open positions for a particular instrument'
  system_id:
    1:
      id: 'all_non_utp_systems'
      doc: 'All Non Utp Systems'
    11:
      id: 'utp_trading_unit_1'
      doc: 'Utp Trading Unit 1'
    12:
      id: 'utp_trading_unit_2'
      doc: 'Utp Trading Unit 2'
  session_type:
    0x45:
      id: 'early_not_used'
      doc: 'Early Not Used'
    0x43:
      id: 'core_session'
      doc: 'Core Session'
    0x4c:
      id: 'late_not_used'
      doc: 'Late Not Used'
  collar_type:
    0x44:
      id: 'dynamic_collars'
      doc: 'Dynamic Collars'
    0x53:
      id: 'static_thresholds'
      doc: 'Static Thresholds'
  stock_exchange_code:
    243:
      id: 'warsaw_stock_exchange'
      doc: 'Warsaw Stock Exchange'
    986:
      id: 'bond_spot_non_exchange_regulated_market'
      doc: 'Bond Spot Non Exchange Regulated Market'
    988:
      id: 'treasury_bond_spot_poland'
      doc: 'Treasury Bond Spot Poland'
    989:
      id: 'bond_spot_ats'
      doc: 'Bond Spot Ats'
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
    0x49:
      id: 'index'
      doc: 'Index'
    0x46:
      id: 'future'
      doc: 'Future'
    0x58:
      id: 'option'
      doc: 'Option'
  type_of_derivatives:
    0x31:
      id: 'inav_indicative_net_asset_value_for_etf_exchange_traded_funds'
      doc: 'Inav Indicative Net Asset Value For Etf Exchange Traded Funds'
    0x34:
      id: 'supports_short_terms_options'
      doc: 'Supports Short Terms Options'
    0x36:
      id: 'supports_long_term_options'
      doc: 'Supports Long Term Options'
    0x39:
      id: 'no_field'
      doc: 'No'
  market_indicator:
    0:
      id: 'not_used'
      doc: 'Not Used'
  algo:
    0x46:
      id: 'fifo'
      doc: 'Fifo'
    0x4f:
      id: 'fifo_origin'
      doc: 'Fifo Origin'
  ss_market_maker:
    0x59:
      id: 'short_sale_is_authorized'
      doc: 'Short Sale Is Authorized'
    0x4e:
      id: 'short_sale_is_forbidden_which_the_561_session_summary_message_words_as_suspended'
      doc: 'Short Sale Is Forbidden Which The 561 Session Summary Message Words As Suspended'
    0x20:
      id: 'not_significant_for_warrants_and_derivatives_instruments_as_well_as_instruments_traded_on_ipo_and_to_segments'
      doc: 'Not Significant For Warrants And Derivatives Instruments As Well As Instruments Traded On Ipo And To Segments'
  ss_non_market_maker:
    0x59:
      id: 'short_sale_is_authorized'
      doc: 'Short Sale Is Authorized'
    0x4e:
      id: 'short_sale_is_forbidden_which_the_561_session_summary_message_words_as_suspended'
      doc: 'Short Sale Is Forbidden Which The 561 Session Summary Message Words As Suspended'
    0x20:
      id: 'not_significant_for_warrants_and_derivatives_instruments_as_well_as_instruments_traded_on_ipo_and_to_segments'
      doc: 'Not Significant For Warrants And Derivatives Instruments As Well As Instruments Traded On Ipo And To Segments'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  delivery_type:
    0x43:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x50:
      id: 'physical_delivery'
      doc: 'Physical Delivery'
  exercise_type:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
  status_indicator:
    0x5a:
      id: 'suspended'
      doc: 'Suspended'
    0x20:
      id: 'active'
      doc: 'Active'
  market:
    0x50:
      id: 'primary_market'
      doc: 'Primary Market'
    0x52:
      id: 'parallel_market'
      doc: 'Parallel Market'
    0x5a:
      id: 'new_connect_market_price_driven_market'
      doc: 'New Connect Market Price Driven Market'
    0x43:
      id: 'new_connect_marketorder_driven_market'
      doc: 'New Connect Marketorder Driven Market'
    0x4f:
      id: 'catalyst_regulated_market'
      doc: 'Catalyst Regulated Market'
    0x4e:
      id: 'catalyst_aso'
      doc: 'Catalyst Aso'
  marker_pct_change_price:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  symbol_delta:
    0x2b:
      id: 'positive_value'
      doc: 'Positive Value'
    0x2d:
      id: 'negative_value'
      doc: 'Negative Value'
    0x20:
      id: 'zero_value'
      doc: 'Zero Value'
  symbol_gamma:
    0x2b:
      id: 'positive_value'
      doc: 'Positive Value'
    0x2d:
      id: 'negative_value'
      doc: 'Negative Value'
    0x20:
      id: 'zero_value'
      doc: 'Zero Value'
  symbol_rho:
    0x2b:
      id: 'positive_value'
      doc: 'Positive Value'
    0x2d:
      id: 'negative_value'
      doc: 'Negative Value'
    0x20:
      id: 'zero_value'
      doc: 'Zero Value'
  symbol_theta:
    0x2b:
      id: 'positive_value'
      doc: 'Positive Value'
    0x2d:
      id: 'negative_value'
      doc: 'Negative Value'
    0x20:
      id: 'zero_value'
      doc: 'Zero Value'
  symbol_vega:
    0x2b:
      id: 'positive_value'
      doc: 'Positive Value'
    0x2d:
      id: 'negative_value'
      doc: 'Negative Value'
    0x20:
      id: 'zero_value'
      doc: 'Zero Value'
  order_entry_rejection:
    0x4e:
      id: 'order_entry_allowed'
      doc: 'Order Entry Allowed'
    0x59:
      id: 'order_entry_forbidden'
      doc: 'Order Entry Forbidden'
  instrument_state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x41:
      id: 'auction'
      doc: 'Auction'
    0x20:
      id: 'inherited_following_the_state_of_the_class_the_instrument_belongs_to'
      doc: 'Inherited Following The State Of The Class The Instrument Belongs To'
  halt_reason:
    0x52:
      id: 'halted_no_liquidity_provider'
      doc: 'Halted No Liquidity Provider'
    0x43:
      id: 'trade_price_outside_dynamic_collars'
      doc: 'Trade Price Outside Dynamic Collars'
    0x4d:
      id: 'manual_halting_by_market_operations'
      doc: 'Manual Halting By Market Operations'
    0x57:
      id: 'regulatory_halting_deactivating_barrier_reached'
      doc: 'Regulatory Halting Deactivating Barrier Reached'
    0x58:
      id: 'regulatory_halting_underlying_halted'
      doc: 'Regulatory Halting Underlying Halted'
    0x47:
      id: 'regulatory_halting_by_mo'
      doc: 'Regulatory Halting By Mo'
    0x53:
      id: 'trade_price_outside_static_collars'
      doc: 'Trade Price Outside Static Collars'
    0x41:
      id: 'number_of_orders_alert'
      doc: 'Number Of Orders Alert'
    0x20:
      id: 'instrument_not_halted_or_information_not_available'
      doc: 'Instrument Not Halted Or Information Not Available'
  action_affecting_state:
    0x43:
      id: 'trading_on_the_instrument_at_the_opening_sent_before_o'
      doc: 'Trading On The Instrument At The Opening Sent Before O'
    0x44:
      id: 'cancelled_programmed_opening'
      doc: 'Cancelled Programmed Opening'
    0x4d:
      id: 'instrument_halted_independently_from_its_class'
      doc: 'Instrument Halted Independently From Its Class'
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
    0x59:
      id: 'beginning_of_a_one_side_only_period'
      doc: 'Beginning Of A One Side Only Period'
    0x5a:
      id: 'end_of_a_one_side_only_period'
      doc: 'End Of A One Side Only Period'
  period_side:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x31:
      id: 'bid_only'
      doc: 'Bid Only'
    0x32:
      id: 'offer_only'
      doc: 'Offer Only'
  authority:
    0x31:
      id: 'wse'
      doc: 'Wse'
    0x32:
      id: 'kdpw'
      doc: 'Kdpw'
    0x33:
      id: 'knf'
      doc: 'Knf'
  msg_type_indicator:
    0x46:
      id: 'functional'
      doc: 'Functional'
    0x54:
      id: 'technical'
      doc: 'Technical'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  language_version:
    0x50:
      id: 'polish_version_of_the_message'
      doc: 'Polish Version Of The Message'
    0x45:
      id: 'english_version_of_the_message'
      doc: 'English Version Of The Message'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  open_position_indicator:
    0x30:
      id: 'open_position_during_the_quotation_phase'
      doc: 'Open Position During The Quotation Phase'
    0x33:
      id: 'open_position_after_the_end_of_the_trading_session'
      doc: 'Open Position After The End Of The Trading Session'
    0x35:
      id: 'open_position_before_the_start_of_the_trading_session_verified_data_from_the_previous_day'
      doc: 'Open Position Before The Start Of The Trading Session Verified Data From The Previous Day'

