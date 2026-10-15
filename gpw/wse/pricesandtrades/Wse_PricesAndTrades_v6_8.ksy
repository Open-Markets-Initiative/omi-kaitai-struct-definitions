# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse PricesAndTrades Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Prices and Trades
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
  id: gpw_wse_pricesandtrades_xdp_v6_8
  title: Gpw Wse PricesAndTrades Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Prices and Trades Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msg_entries

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
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::trade_full_information_message': trade_full_information_message
            'message_type::price_update_message': price_update_message
            'message_type::trade_publication_message': trade_publication_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::vwap_closing_price_message': vwap_closing_price_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  trade_full_information_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the Trade generation time. Milliseconds since Midnight epoch'
      - id: trade_id_number
        type: u4
        doc: 'Unique numeric and increasing Identifier of the trade, set by the trading engine'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the transaction was executed'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indication as to whether the price is expressed in monetary value, in percentage or in yield'
      - id: transaction_to_be_cleared
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code to identify whether the transaction will be cleared'
      - id: cumulative_quantity
        type: u4
        doc: 'Cumulative number of securities traded on UTP since the start of the current trading session Note: Value accumulated within the individual segments'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: variation_last_price
        type: s4
        doc: 'Percentage variation of Last Traded Price to last reference price (signed) (To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the price is expressed as defined by ISO 4217 (applicable if the price is expressed as monetary value)'
      - id: last_trade_indicator
        type: u1
        enum: last_trade_indicator
        doc: 'Last trade at same price indicator'
      - id: type_of_trade
        type: u1
        enum: type_of_trade
        doc: 'Trade related conditions'
      - id: trade_origin
        type: u1
        enum: trade_origin
        doc: 'This field indicates the origin of the trade'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'Symbol of the variation of the price versus the previous (traded or reference) price'
      - id: opening_trade_indicator
        type: u1
        enum: opening_trade_indicator
        doc: 'If the trade took place during the opening auction or during the core session'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with VariationLastPrice'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message except for the field "Price"'
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed'
      - id: publication_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was published by a trading venue'
      - id: instrument_id_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code type used to identify the financial instrument Always equal to ''ISIN'''
      - id: instrument_id_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code used to identify the financial instrument, as defined in ISO 6166'
      - id: price_ascii_ch_20
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded price of the transaction excluding, where applicable, commission and accrued interest'
      - id: quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument, or the number of derivative contracts in the transaction'
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
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: transaction_id_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Alphanumerical code assigned by trading venue used in any subsequent reference to the specific trade'
      - id: mmt_market_mechanism
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines the market mechanism following MMT level 1'
      - id: mmt_trading_mode
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines the trading Mode mechanism following MMT level 2 Possible values: - ''1'': Undefined Auction (not used) - ''O'': Scheduled Opening Auction - ''K'': Scheduled Closing Auction - ''I'': Scheduled Intraday Auction (not used) - ''U'': Unscheduled Auction - ''2'': Continuous Trading - ''3'': At Market Close Trading - ''4'': Out of Main Session Trading (not used) - ''5'': Trade Reporting (On Exchange) - ''6'': Trade Reporting (Off Exchange) - ''7'': Trade Reporting (Systematic Internaliser) (not used)'
      - id: mmt_algorithmic_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the algorithmic indicator following MMT level 3.9'
      - id: mmt_modification_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the modification indicator following MMT level 3.4'
      - id: mmt_negotiation_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the negotiation indicator or pre-trade transparency waiver following MMT level 3.2'
      - id: mmt_special_dividend_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the special dividend indicator following MMT level 3.6'
      - id: mmt_contribution_to_price
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the contribution to price or the price discovery process following MMT level 3.8'
      - id: mmt_benchmark_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the benchmark indicator or the reference price indicator following MMT level 3.5'
  price_update_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the Trade generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: price_binary_int_4
        type: u4
        doc: 'Last Price of the trading day (To be calculated with the ScaleCode)'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: variation_last_price
        type: s4
        doc: 'Percentage variation of Last Traded Price to last reference price (signed) (To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: type_of_price
        type: u2
        enum: type_of_price
        doc: 'Market- Code identifying the type of price that is updated'
      - id: reserved_2
        size: 2
        doc: 'For future use'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message except for the field "Price"'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with VariationLastPrice'
  trade_publication_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the Trade generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the transaction was executed'
      - id: instrument_id_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code type used to identify the financial instrument Always equal to ''ISIN'''
      - id: price_multiplier
        type: u4
        doc: 'Number of units of the financial instrument that are contained a trading lot (to be calculated with the MultiplierScaleCode)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the price is expressed as defined by ISO 4217 (applicable if the price is expressed as monetary value)'
      - id: instrument_id_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code used to identify the financial instrument, as defined in ISO 6166'
      - id: publication_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was published by a trading venue'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the notional is denominated as defined by ISO 4217'
      - id: tcs_trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference of the trade'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indication as to whether the price is expressed in monetary value, in percentage or in yield'
      - id: reserved_1
        size: 1
        doc: 'For future use'
      - id: transaction_to_be_cleared
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code to identify whether the transaction will be cleared'
      - id: mmt_benchmark_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the benchmark indicator or the reference price indicator following MMT level 3.5'
      - id: mmt_contribution_to_price
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the contribution to price or the price discovery process following MMT level 3.8'
      - id: multiplier_scale_code
        type: u1
        doc: 'To be combined with PriceMultiplier'
      - id: price_ascii_ch_20
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded price of the transaction excluding, where applicable, commission and accrued interest'
      - id: quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument, or the number of derivative contracts in the transaction'
      - id: notional_amount
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Nominal amount or notional amount'
      - id: transaction_id_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Alphanumerical code assigned by trading venue used in any subsequent reference to the specific trade'
      - id: mmt_market_mechanism
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines the market mechanism following MMT level 1'
      - id: mmt_trading_mode
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines the trading Mode mechanism following MMT level 2 Possible values: - ''1'': Undefined Auction (not used) - ''O'': Scheduled Opening Auction - ''K'': Scheduled Closing Auction - ''I'': Scheduled Intraday Auction (not used) - ''U'': Unscheduled Auction - ''2'': Continuous Trading - ''3'': At Market Close Trading - ''4'': Out of Main Session Trading (not used) - ''5'': Trade Reporting (On Exchange) - ''6'': Trade Reporting (Off Exchange) - ''7'': Trade Reporting (Systematic Internaliser) (not used)'
      - id: mmt_special_dividend_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the special dividend indicator following MMT level 3.6'
      - id: mmt_negotiation_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the negotiation indicator or pre-trade transparency waiver following MMT level 3.2'
      - id: mmt_agency_cross_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transactions where an investment firm has brought together clients'' orders with the purchase and the sale conducted as one transaction and involving the same volume and price'
      - id: mmt_transaction_category
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the transaction category following MMT level 3.1'
      - id: mmt_modification_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the modification indicator following MMT level 3.4'
      - id: mmt_duplicative_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the duplicative indicator following MMT level 5'
      - id: mmt_publication_mode
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the publication mode or post- trade deferral reason following MMT level 4.1'
      - id: mmt_algorithmic_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the algorithmic indicator following MMT level 3.9'
      - id: reserved_2
        size: 2
        doc: 'For future use'
  auction_summary_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the Trade generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: first_price
        type: u4
        doc: 'First traded price for the current trading day (To be calculated with the PriceScaleCode)'
      - id: last_price
        type: u4
        doc: 'Most recent traded price for the current trading day (until the message is sent)'
      - id: highest_price
        type: u4
        doc: 'Highest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: lowest_price
        type: u4
        doc: 'Lowest Price traded during the day(To be calculated with the PriceScaleCode)'
      - id: cumulative_quantity
        type: u4
        doc: 'Cumulative number of securities traded on UTP since the start of the current trading session Note: Value accumulated within the individual segments'
      - id: variation
        type: s4
        doc: 'Percentage variation of the last trade price against the previous day''s reference price for the instrument (signed) concerned, ie the last known price or the last price indication (variation price).(To be calculated with the VariationScaleCode)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: type_of_last_price
        type: u2
        enum: type_of_last_price
        doc: 'Indicates the message trade type'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'Symbol of the variation of the price versus the previous (traded or reference) price'
      - id: instrument_valuation_price
        type: u1
        enum: instrument_valuation_price
        doc: 'Indicates whether the data item "last price" is a valuation price following a valuation trade'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message except for the field "Price"'
      - id: variation_scale_code
        type: u1
        doc: 'To be combined with VariationLastPrice'
  vwap_closing_price_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the Trade generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: sending_indicator
        type: u2
        enum: sending_indicator
        doc: 'Indicates the "sending mode"'
      - id: closing_price_rule
        type: u2
        enum: closing_price_rule
        doc: 'Indicates the Closing Price calculation rule'
      - id: closing_price
        type: u4
        doc: 'Current VWAP/Closing Price (To be calculated with the ScaleCode) Not Provided for Derivatives'
      - id: adjusted_closing_price
        type: u4
        doc: 'Adjusted VWAP/Closing Price (To be calculated with the ScaleCode)'
      - id: nb_trades
        type: u4
        doc: 'Number of Trades executed on this Instrument since the beginning of the Trading Day'
      - id: amount_traded
        type: u8
        doc: 'Total cumulated amount traded on this instrument since the beginning of the Trading day (To be calculated with the ScaleCode) Not Provided for Derivatives'
      - id: qty_shares
        type: u4
        doc: 'Cumulated Quantity traded (number of securities) on this instrument since the beginning of the Trading Day Not Provided for Derivatives'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: scale_code
        type: u1
        doc: 'Applicable to ClosingPrice, AdjustedClosingPrice and AmountTraded'
      - id: reserved_5
        size: 5
        doc: 'Reserved for future use'
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
    240:
      id: 'trade_full_information_message'
      doc: 'Trade full information message is sent each time a trade or a cancellation of a trade has occurred'
    241:
      id: 'price_update_message'
      doc: 'The Price update message contains a bid price or an ask price in case of alternative indicative price (AIP), or the modification of the last reference price on a given instrument'
    243:
      id: 'trade_publication_message'
      doc: 'A trade publication message is sent by the reporting system whenever a trade is reported'
    245:
      id: 'auction_summary_message'
      doc: 'An Auction Summary message summarizes an instrument''s opening or auction trades'
    247:
      id: 'vwap_closing_price_message'
      doc: 'This message contains the Volume-Weighted Average Price for an instrument, along with few statistical information related to the cumulated traded value and volume'
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
  last_trade_indicator:
    0x30:
      id: 'not_last_of_a_series_of_trade_at_the_same_price'
      doc: 'Not Last Of A Series Of Trade At The Same Price'
    0x31:
      id: 'last_of_a_series_of_trade_at_the_same_price_and'
      doc: 'Last Of A Series Of Trade At The Same Price And'
  type_of_trade:
    0x30:
      id: 'trade_does_not_stem_from_a_cross_order'
      doc: 'Trade Does Not Stem From A Cross Order'
    0x31:
      id: 'trade_stems_from_a_cross_order'
      doc: 'Trade Stems From A Cross Order'
    0x34:
      id: 'valuation_trade'
      doc: 'Valuation Trade'
    0x35:
      id: 'internalized_trade'
      doc: 'Internalized Trade'
    0x36:
      id: 'internalized_cross_trade'
      doc: 'Internalized Cross Trade'
  trade_origin:
    0x42:
      id: 'orders_from_the_book'
      doc: 'Orders From The Book'
    0x4f:
      id: 'block_trade'
      doc: 'Block Trade'
    0x49:
      id: 'ipo_trade'
      doc: 'Ipo Trade'
    0x54:
      id: 'tender_offer_trade'
      doc: 'Tender Offer Trade'
    0x53:
      id: 'biso_trade'
      doc: 'Biso Trade'
    0x52:
      id: 'trade_reporting_for_future_use'
      doc: 'Trade Reporting For Future Use'
  tick_direction:
    0x2b:
      id: 'positive_rising'
      doc: 'Positive Rising'
    0x2d:
      id: 'negative_falling'
      doc: 'Negative Falling'
    0x30:
      id: 'no_variation_unchanged_or_data_field_not_significant_used_for_trade_cancellation'
      doc: 'No Variation Unchanged Or Data Field Not Significant Used For Trade Cancellation'
  opening_trade_indicator:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'core_continuous'
      doc: 'Core Continuous'
    0x20:
      id: 'bond_spot_always_fills_the_field_with_a_space'
      doc: 'Bond Spot Always Fills The Field With A Space'
  type_of_price:
    2:
      id: 'bid_price'
      doc: 'Bid Price'
    3:
      id: 'ask_price'
      doc: 'Ask Price'
    30:
      id: 'first_traded_price_of_the_day'
      doc: 'First Traded Price Of The Day'
    33:
      id: 'new_last_price'
      doc: 'New Last Price'
    34:
      id: 'new_previous_days_closing_price_the_last_adjusted_closing_price_or_lp_midpoint'
      doc: 'New Previous Days Closing Price The Last Adjusted Closing Price Or Lp Midpoint'
    35:
      id: 'daily_settlement_price'
      doc: 'Daily Settlement Price'
    36:
      id: 'final_settlement_price'
      doc: 'Final Settlement Price'
    37:
      id: 'theoretical_price'
      doc: 'Theoretical Price'
    51:
      id: 'alternative_indicative_price_aip'
      doc: 'Alternative Indicative Price Aip'
  type_of_last_price:
    4:
      id: 'first_traded_price'
      doc: '1 St Traded Price'
    7:
      id: 'n_th_traded_price_resume_after_unhalting_of_the_instrument'
      doc: 'N Th Traded Price Resume After Unhalting Of The Instrument'
  instrument_valuation_price:
    0x30:
      id: 'not_a_valuation_price'
      doc: 'Not A Valuation Price'
    0x31:
      id: 'valuation_price'
      doc: 'Valuation Price'
  sending_indicator:
    1:
      id: 'real_time_not_used_for_wse'
      doc: 'Real Time Not Used For Wse'
    2:
      id: 'batch_mode'
      doc: 'Batch Mode'
  closing_price_rule:
    1:
      id: 'ltp_last_traded_price'
      doc: 'Ltp Last Traded Price'
    2:
      id: 'vwap_volume_weighted_average_price_not_provided_for_derivatives'
      doc: 'Vwap Volume Weighted Average Price Not Provided For Derivatives'

