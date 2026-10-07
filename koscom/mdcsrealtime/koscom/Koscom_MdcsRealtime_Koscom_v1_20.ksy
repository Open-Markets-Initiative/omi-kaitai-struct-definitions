# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime Koscom Exture v1.20
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Koscom
#   Encoding: Exture
#   Version: 1.20
#   Date: 5/26/2022
#   Specification: Unknown
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
  id: koscom_mdcsrealtime_koscom_exture_v1_20
  title: Koscom MdcsRealtime Koscom Exture v1.20
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Koscom Exture v1.20'
doc-ref: https://data.koscom.co.kr

seq:
  - id: message_code
    type: str
    size: 5
    encoding: ASCII
    pad-right: 0x20
    doc: 'Five-character ASCII TR-CODE identifying the disseminated market data record. Formed by concatenating a 2-character Data Category (message family, e.g. "IA" Krx Index, "B6" Quote, "C4" Negotiated Trade, "A7" Market Operation TS) with a 3-character Information Category (market/product variant, typically 2-digit information code plus 1-character market code, e.g. "01S" = Equities/KOSPI, "01F" = Derivatives, "000" = All Market)'
  - id: payload
    type:
      switch-on: message_code
      cases:
        '"A6013"': k_otc_issue_closing_message
        '"A7013"': k_otc_market_operation_message
        '"G5013"': k_otc_market_action_message
        '"A2013"': k_otc_quote_message
        '"A3013"': k_otc_order_filled_message
        '"J6077"': otc_bond_traded_info_message
        '"J7077"': otc_bond_trades_per_institution_message
        '"C1077"': otc_bond_types_per_investor_message
        '"L9077"': k_bond_message
        '"E2000"': mkf_index_message
        '"O9000"': mkf_index_jpy_message
        '"P3000"': wisefn_index_message
        '"BP000"': kis_index_message
        '"K0000"': mkf_bond_index_message
        '"L6000"': kis_bond_index_message
        '"K6000"': kebi_bond_index_message
        '"Q6000"': kabi_bond_index_message
        '"CE000"': nicepni_bond_index_message
        '"BV03S"': domestic_etf_inav_message
        '"BW03S"': domestic_etf_estimated_inav_message
        '"L503S"': global_etf_inav_message
        '"P603S"': etf_tracking_error_message
        '"P703S"': global_etf_tracking_error_message
        '"F803S"': etp_pdf_message
        '"M803S"': etp_operator_information_message
        '"M805S"': etp_operator_information_message
        '"M801Q"': etp_operator_information_message
        '"N803S"': etp_transfer_agent_batch_message
        '"N805S"': etp_transfer_agent_batch_message
        '"N801Q"': etp_transfer_agent_batch_message
        '"Q403S"': etf_risk_appraisement_message
        '"Q503S"': synthetic_etf_constituents_message
        '"C702S"': elw_investment_indicator_sensitivity_message
        '"S304S"': etn_iiv_message
        '"X404S"': etn_disparate_ratio_message
        '"CC000"': loan_transaction_available_quantity_message

types:
  k_otc_issue_closing_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: closing_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Closing Price'
      - id: quotation_category
        type: u1
        enum: quotation_category
        doc: '0:Weighted Avg Price,1:Quotation,2:No Trade'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  k_otc_market_operation_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: type_field
        type: u1
        enum: type_field
        doc: '1:trading halt 2: lift after trading halt'
      - id: reason
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  k_otc_market_action_message:
    seq:
      - id: isin_nullable
        type: str_12_nullable
        doc: 'Standard Code(ISIN) ISIN ← Issue code (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: data_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '01: change of basis price and upper/lower limit price 02: temporary halt, 03: resumption after temporary halt'
      - id: change_date
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD(in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: change_time
        type: hhmmssmm_ascii_time
        doc: 'HHMMSSMM(in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: basis_price_before_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: upper_limit_price_before_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: lower_limit_price_before_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: basis_price_after_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: upper_limit_price_after_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: lower_limit_price_after_action
        type: str_9_nullable
        doc: 'Unit: KRW (in case that data type is not 01, then "0"). Nullable, No Value = 0'
      - id: filler_10
        type: str
        size: 10
        encoding: ASCII
        doc: 'SPACE 2026.08.10 changed'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  k_otc_quote_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: process_type
        type: u1
        enum: process_type
        doc: '1: normal 2: correction 3: cancellation'
      - id: quote_number
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quote number in case of normal process'
      - id: original_quote_number
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Normal: 0, in case of correction/cancellation, relevant original quote is number'
      - id: original_quote_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Normal: 0, in case of correction/cancellation, original price'
      - id: bidask_type
        type: u1
        enum: bidask_type
        doc: '1: ask, 2:bid'
      - id: price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Normal: order price Correction: correction price'
      - id: quantity
        type: str
        size: 10
        encoding: ASCII
        doc: 'Normal: order quantity Correction/cancellation: actual correction/cancellation quantity'
      - id: subscription_time
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Subscription time'
      - id: total_remaining_quantity_of_ask
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total remaining quantity of ask'
      - id: total_remaining_quantity_of_bid
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total remaining quantity of bid'
      - id: ask_best_order
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask best order'
      - id: remaining_quantity_of_ask_best_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Remaining quantity of ask best order'
      - id: bid_best_order
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid best order'
      - id: remaining_quantity_of_bid_best_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Remaining quantity of bid best order'
      - id: price_compare_remaining_quantity_of_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Normal: remaining quantity of order Correction: remaining quantity of correction'
      - id: original_price_compare_remaining_quantity_of_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Normal: 0, in case of correction/cancellation, original remaining quantity'
      - id: securities_company_number
        type: str
        size: 3
        encoding: ASCII
        doc: 'Refer to trading original type code'
      - id: branch_name
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPACE'
      - id: filler_33
        type: str
        size: 33
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  k_otc_order_filled_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: trading_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Trading number for each issue'
      - id: trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trading price'
      - id: trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume (12 ASCII digits). Unit: 1,000 shares'
      - id: trading_time
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading time'
      - id: ask_quote_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'quote number for each issue'
      - id: bid_quote_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'quote number for each issue'
      - id: high_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'High price'
      - id: low_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Low price'
      - id: weighted_average_stock_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Weighted average stock price'
      - id: total_trading_accumulated_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total trading accumulated Volume'
      - id: total_trading_accumulated_value
        type: str
        size: 14
        encoding: ASCII
        doc: 'Total trading accumulated value'
      - id: total_remaining_quantity_of_ask
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total remaining quantity of ask'
      - id: total_remaining_quantity_of_bid
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total remaining quantity of bid'
      - id: best_ask_order
        type: str
        size: 9
        encoding: ASCII
        doc: 'Best ask order'
      - id: remaining_quantity_of_best_ask_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Remaining quantity of best ask order'
      - id: best_bid_order
        type: str
        size: 9
        encoding: ASCII
        doc: 'Best bid order'
      - id: remaining_quantity_of_best_bid_order
        type: str
        size: 10
        encoding: ASCII
        doc: 'Remaining quantity of Best bid order'
      - id: compared_to_previous_day_type
        type: u1
        enum: compared_to_previous_day_type
        doc: '+: up -: down space: steadiness'
      - id: compared_to_previous_day
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Compared to previous day'
      - id: trading_price_compare_remaining_quantity_of_ask
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading price compare remaining quantity of ask'
      - id: trading_price_compare_remaining_quantity_of_bid
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading price compare remaining quantity of bid'
      - id: filler_40
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  otc_bond_traded_info_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: subcategory
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '51:Today''s Trading History in OTC 52:Previous Day''s Trading History in OTC 53:Omitted Info. in past OTC Trading History 54:Changed/Canceled Info. in past OTC Trading History'
      - id: trading_date
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD'
      - id: registered_time
        type: hhmmss_ascii_time
        doc: 'HHMMSS'
      - id: process_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Normal 2:Amended 3:Cancel'
      - id: registered_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Registered Number'
      - id: originally_registered_number
        type: str
        size: 8
        encoding: ASCII
        doc: '0:Normal Originally Registered Number:Change/Cancel'
      - id: trading_type_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Self-dealings 2:Cross Trading 3:Brokerage 9:Other'
      - id: volume
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unit: 1 KRW, 1 USD, 1 YEN, 1 EURO, 1 CNY, 1 GBP, 1 HKD, 1 AUD, 1 SGD, miscellaneous'
      - id: pretax_unit_price
        type: str
        size: 8
        encoding: ASCII
        doc: '999999V99(Unit:1 KRW, 1 USD, 1YEN, 1 EURO, 1CNY, 1GBP, 1HKD, 1AUD, 1SGD, miscellaneous). Implied decimal with scale 1e-2'
      - id: pretax_yield
        type: str
        size: 8
        encoding: ASCII
        doc: '999V99999. Implied decimal with scale 1e-5'
      - id: settlement_date_otc
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD'
      - id: market_base_rate
        type: str
        size: 8
        encoding: ASCII
        doc: '999V99999, FRN. Implied decimal with scale 1e-5'
      - id: fx_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:KRW 2:USD 3:YEN 4:EURO 5:CNY 6:GBP 7:HKD 8:AUD 9:SGD 0:miscellaneous'
      - id: based_fx
        type: str
        size: 8
        encoding: ASCII
        doc: '9999V9999(KRW/USD, KRW/YEN, KRW/EURO, KRW/CNY, KRW/GBP, KRW/HKD, KRW/AUD, KRW/SGD, KRW/miscellaneous). Implied decimal with scale 1e-4'
      - id: trading_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '2:Brokerage 4:Direct Participant'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  otc_bond_trades_per_institution_message:
    seq:
      - id: data_process_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'I:Normal D:Delete E:End'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: institution_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to Code Table'
      - id: bond_type_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '1:KTB 2:MB 3:Special Bond 4:MSB 5:Financial Bond 6:Corporate Bond'
      - id: ask_yield_institution
        type: str
        size: 8
        encoding: ASCII
        doc: '9999V9999. Implied decimal with scale 1e-4'
      - id: ask_trading_volume_institution
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Thousand KRW'
      - id: ask_trading_value_institution
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Thousand KRW'
      - id: bid_yield_institution
        type: str
        size: 8
        encoding: ASCII
        doc: '9999V9999. Implied decimal with scale 1e-4'
      - id: bid_trading_volume_institution
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Thousand KRW'
      - id: bid_trading_value_institution
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Thousand KRW'
      - id: filler_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  otc_bond_types_per_investor_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Records Checking Purpose'
      - id: trading_date
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD'
      - id: investor_category
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to Code Table'
      - id: ask_yield_investor
        type: str
        size: 10
        encoding: ASCII
        doc: '99999V99999. Implied decimal with scale 1e-5'
      - id: bid_yield_investor
        type: str
        size: 10
        encoding: ASCII
        doc: '99999V99999. Implied decimal with scale 1e-5'
      - id: ask_trading_volume_investor
        type: str
        size: 20
        encoding: ASCII
        doc: 'Ask Trading Volume'
      - id: bid_trading_volume_investor
        type: str
        size: 20
        encoding: ASCII
        doc: 'Bid Trading Volume'
      - id: ask_trading_value_investor
        type: str
        size: 20
        encoding: ASCII
        doc: 'Ask Trading Value'
      - id: bid_trading_value_investor
        type: str
        size: 20
        encoding: ASCII
        doc: 'Bid Trading Value'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  k_bond_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_small_category
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'H1:Quotes /Trading H2:Quotes /Trading Change Detail'
      - id: data_source_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPACE set to FILLER'
      - id: sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Records Checking Purpose'
      - id: original_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'In case of H1 data : 00000000 Original Sequence Number ← Previous ISIN'
      - id: replacement_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0:ordinary order, 1:replacement order'
      - id: previous_isin_of_replacement
        type: str
        size: 8
        encoding: ASCII
        doc: 'Except for the second price of replacement order : 00000000'
      - id: input_date
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD'
      - id: quotes_offer_time
        type: hhmmss_ascii_time
        doc: 'Quotes generated time(HHMMSS)'
      - id: bond_type_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded Bond Type Name'
      - id: change_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Newly added, 2:Update a current announcemet, 3:Deleted'
      - id: market_data_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Profit rate, 2:Price'
      - id: profit_rate_quotes_trading
        type: str
        size: 8
        encoding: ASCII
        doc: '999V99999. Implied decimal with scale 1e-5'
      - id: price_quotes_trading
        type: str
        size: 8
        encoding: ASCII
        doc: '99999V999 Unit: KRW. Implied decimal with scale 1e-3'
      - id: contract_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Bid 2:Ask 3: Trading'
      - id: quotes_amount
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'KRW(Data transmitted only for Bid(1)/Ask(2) on ''Contract category'' field)'
      - id: contract_date
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '1:Outstanding Negotiation, 2:T+0, 3:T+1, 4:T+2, ~ 32:T+30'
      - id: settlement_date_k_bond
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '2:T+0(On one day), 3:T+1(Next day), 4:T+2, ~ 32:T+30'
      - id: filler_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  mkf_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current MKF Index value (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' steadiness, ''-'' declined'
      - id: comparison
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume (12 ASCII digits). Unit: 1,000 shares'
      - id: trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value (12 ASCII digits). Unit: 1,000,000 KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  mkf_index_jpy_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current MKF Index value (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' steadiness, ''-'' declined'
      - id: comparison
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume (12 ASCII digits). Unit: 1,000 shares'
      - id: trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value (12 ASCII digits). Unit: 1,000,000 KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  wisefn_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current MKF Index value (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' steadiness, ''-'' declined'
      - id: comparison
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume (12 ASCII digits). Unit: 1,000 shares'
      - id: trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value (12 ASCII digits). Unit: 1,000,000 KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  kis_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current MKF Index value (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: sign
        type: u1
        enum: sign
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' steadiness, ''-'' declined'
      - id: comparison
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume (12 ASCII digits). Unit: 1,000 shares'
      - id: trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value (12 ASCII digits). Unit: 1,000,000 KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  mkf_bond_index_message:
    seq:
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: standard_date
        type: yyyymmdd_ascii_date
        doc: 'Standard date for the index calculation in YYYYMMDD format'
      - id: standard_time
        type: hhmmss_ascii_time
        doc: 'Standard time in HHMMSS. Range 09:00:00 to ~15:30. Cycle: 1 min'
      - id: total_profit_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total profit index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: clean_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: market_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: call_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Call re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: zero_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Zero re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: futures_basis_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Futures basis price (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: average_duration_nullable
        type: str_6_nullable
        doc: 'Average duration (6 ASCII digits with 3 implied decimal places). Not calculated for MKF; set to ''0''. Implied decimal with scale 1e-3. Nullable, No Value = 0'
      - id: average_convexity
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average convexity (6 ASCII digits with 3 implied decimal places). Implied decimal with scale 1e-3'
      - id: average_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: average_forward_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average forward yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  kis_bond_index_message:
    seq:
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: standard_date
        type: yyyymmdd_ascii_date
        doc: 'Standard date for the index calculation in YYYYMMDD format'
      - id: standard_time
        type: hhmmss_ascii_time
        doc: 'Standard time in HHMMSS. Range 09:00:00 to ~15:30. Cycle: 1 min'
      - id: total_profit_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total profit index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: clean_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: market_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: call_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Call re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: zero_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Zero re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: futures_basis_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Futures basis price (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: average_duration
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average duration. Implied decimal with scale 1e-3'
      - id: average_convexity
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average convexity (6 ASCII digits with 3 implied decimal places). Implied decimal with scale 1e-3'
      - id: average_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: average_forward_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average forward yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  kebi_bond_index_message:
    seq:
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: standard_date
        type: yyyymmdd_ascii_date
        doc: 'Standard date for the index calculation in YYYYMMDD format'
      - id: standard_time
        type: hhmmss_ascii_time
        doc: 'Standard time in HHMMSS. Range 09:00:00 to ~15:30. Cycle: 1 min'
      - id: total_profit_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total profit index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: clean_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: market_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: call_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Call re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: zero_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Zero re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: futures_basis_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Futures basis price (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: average_duration_nullable
        type: str_6_nullable
        doc: 'Average duration (6 ASCII digits with 3 implied decimal places). Not calculated for MKF; set to ''0''. Implied decimal with scale 1e-3. Nullable, No Value = 0'
      - id: average_convexity
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average convexity (6 ASCII digits with 3 implied decimal places). Implied decimal with scale 1e-3'
      - id: average_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: average_forward_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average forward yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  kabi_bond_index_message:
    seq:
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: standard_date
        type: yyyymmdd_ascii_date
        doc: 'Standard date for the index calculation in YYYYMMDD format'
      - id: standard_time
        type: hhmmss_ascii_time
        doc: 'Standard time in HHMMSS. Range 09:00:00 to ~15:30. Cycle: 1 min'
      - id: total_profit_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total profit index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: clean_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: market_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: call_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Call re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: zero_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Zero re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: futures_basis_price_nullable
        type: str_9_nullable
        doc: 'Futures basis price. Not calculated; set to ''0''. Implied decimal with scale 1e-2. Nullable, No Value = 0'
      - id: average_duration
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average duration. Implied decimal with scale 1e-3'
      - id: average_convexity
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average convexity (6 ASCII digits with 3 implied decimal places). Implied decimal with scale 1e-3'
      - id: average_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: average_forward_ytm_nullable
        type: str_6_nullable
        doc: 'Average forward YTM. Unit: percent. Not calculated; set to ''0''. Implied decimal with scale 1e-3. Nullable, No Value = 0'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  nicepni_bond_index_message:
    seq:
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'MKF Bond Index identifier. Refer to the Code Table sheet'
      - id: standard_date
        type: yyyymmdd_ascii_date
        doc: 'Standard date for the index calculation in YYYYMMDD format'
      - id: standard_time
        type: hhmmss_ascii_time
        doc: 'Standard time in HHMMSS. Range 09:00:00 to ~15:30. Cycle: 1 min'
      - id: total_profit_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Total profit index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: clean_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: market_price_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market price index (10 ASCII digits with 4 implied decimal places). Standard 10,000. Implied decimal with scale 1e-4'
      - id: call_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Call re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: zero_re_investment_index
        type: str
        size: 10
        encoding: ASCII
        doc: 'Zero re-investment index (10 ASCII digits with 4 implied decimal places). Implied decimal with scale 1e-4'
      - id: futures_basis_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Futures basis price (9 ASCII digits with 2 implied decimal places). Implied decimal with scale 1e-2'
      - id: average_duration_nullable
        type: str_6_nullable
        doc: 'Average duration (6 ASCII digits with 3 implied decimal places). Not calculated for MKF; set to ''0''. Implied decimal with scale 1e-3. Nullable, No Value = 0'
      - id: average_convexity
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average convexity (6 ASCII digits with 3 implied decimal places). Implied decimal with scale 1e-3'
      - id: average_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: average_forward_ytm
        type: str
        size: 6
        encoding: ASCII
        doc: 'Average forward yield to maturity (6 ASCII digits with 3 implied decimal places). Unit: percent. Implied decimal with scale 1e-3'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII space'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  domestic_etf_inav_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: previous_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: during_marketfinal_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: filler_28
        type: str
        size: 28
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  domestic_etf_estimated_inav_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: previous_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: during_marketfinal_market_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: filler_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  global_etf_inav_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: previous_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: during_marketfinal_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: filler_28
        type: str
        size: 28
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etf_tracking_error_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Transmission Sequence Number to check number of orders'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: tracking_error
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2), Unit:%. Implied decimal with scale 1e-2'
      - id: disparate_ratio_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPACE:0, ''+'':>0, ''-'':<0'
      - id: disparate_ratio
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2), Unit:%. Implied decimal with scale 1e-2'
      - id: filler_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  global_etf_tracking_error_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Transmission Sequence Number to check number of orders'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: tracking_error
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2), Unit:%. Implied decimal with scale 1e-2'
      - id: disparate_ratio_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPACE:0, ''+'':>0, ''-'':<0'
      - id: disparate_ratio
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2), Unit:%. Implied decimal with scale 1e-2'
      - id: filler_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etp_pdf_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: office_consignment_companys_registration_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '049: Korea Fund Partners ← Mirae Asset Fund Services 905: Shinhan Fund Partners ← Shinhanaitas 906: WOORI FUND SERVICES 2023.04.10 new 907: HANA FUND SERVICES 2024.09.09 new 909: KB FUND PARTNERS 2024'
      - id: composition_issue_number
        type: str
        size: 4
        encoding: ASCII
        doc: 'Unit: issue (including cash)'
      - id: composition_issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'KRD010010001:KRW CASH listed futures: isin code, in case of non-listed, separated definition: futures in case of non-listed, separate definition CP added : KRZ + 9 digits FXFWD0000USD : FX Forward(USD'
      - id: cu_unit_sharenumber_of_contractkrw_cashusd_cashconverted_amountkrw
        type: str
        size: 18
        encoding: ASCII
        doc: '※1cu unit share/number of contract/krw cash/usd cash/warehouse warrant unit is defined by the composion issue code(7th field) - stock→unit:share (if the first field is "-"(minus signal), it means shor'
      - id: composition_issue_market_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: KOSPI(Including cash,KSP200T00001,FKSP200T0001) 1:KOSDAQ 2: Others 3:Bond 4: Futures 2010.04.09 5: spot'
      - id: composition_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of foreign issue is issue name. For others, ''0'' or SPACE'
      - id: par_value_amount_cash_amount_converted_amount_krw
        type: str
        size: 18
        encoding: ASCII
        doc: 'in case of par value, composition issue code is bond, futures, swap,FX Forward cash amount set:in case cu unit set redemption, possible cash setting is displayed based o etf code, current stock index'
      - id: profit_distribution_basis_date
        type: yyyymmdd_ascii_date
        doc: 'only for bond etf. date when profit distribution occurs for the following etf. same value about the special date''s duplicate etf code default : space or "0", yyyymmdd'
      - id: appraised_value
        type: str
        size: 18
        encoding: ASCII
        doc: 'Appraised Value'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etp_operator_information_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Transmission Sequence Number to check number of orders'
      - id: office_consignment_companys_registration_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '049: Korea Fund Partners ← Mirae Asset Fund Services 905: Shinhan Fund Partners ← Shinhanaitas 906: WOORI FUND SERVICES 2023.04.10 new 907: HANA FUND SERVICES 2024.09.09 new 909: KB FUND PARTNERS 2024'
      - id: operator_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Operator Code'
      - id: operator_abbreviated_name_korean
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Operator Abbreviated Name (Korean)'
      - id: operator_abbreviated_name_english
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Operator Abbreviated Name (English)'
      - id: filler_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etp_transfer_agent_batch_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: filler_10
        type: str
        size: 10
        encoding: ASCII
        doc: 'SPACE 2026.08.10 changed'
      - id: etf_flow_net_asset_total_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'ETF Flow Net Asset total amount'
      - id: etf_foreign_net_asset_value_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit: KRW'
      - id: etf_net_asset_value_amount
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2) Information Category 03S: Final NAV of the previous business day, Fund unit Information Category 05S: TU unit Information Category 01Q: Final NAV of the previous business day, Fund unit. Implied decimal with scale 1e-2'
      - id: etf_foreign_flow_net_asset_total_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'ETF Foreign Flow Net Asset Total Amount'
      - id: etf_foreign_net_asset_total
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'ETF Foreign Net Asset Total'
      - id: etf_foreign_final_net_asset_value
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2). Implied decimal with scale 1e-2'
      - id: etf_cu_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unit: Securities'
      - id: previous_days_tax_base_nav
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99 Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: previous_days_tax_base_nav_before_dividend
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99 Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: previous_days_cash_dividend_amount
        type: str
        size: 12
        encoding: ASCII
        doc: '9999999999V99 Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: tax_base_nav_as_of_the_day_before_the_previous_day
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99 Information Category 03S: Fund unit, 05S: TU unit. Implied decimal with scale 1e-2'
      - id: previous_days_nontaxable_base_price_for_overseas_stocks
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99. Implied decimal with scale 1e-2'
      - id: previous_days_nontaxable_base_price_before_dividend_for_overseas_stocks
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99. Implied decimal with scale 1e-2'
      - id: day_before_previous_days_nontaxable_base_price_for_overseas_stocks
        type: str
        size: 9
        encoding: ASCII
        doc: '9999999V99. Implied decimal with scale 1e-2'
      - id: number_of_freefloating_etf_shares
        type: str
        size: 16
        encoding: ASCII
        doc: 'Information Category 03S: Fund unit, 05S: TU unit'
      - id: filler_46
        type: str
        size: 46
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etf_risk_appraisement_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: office_consignment_companys_registration_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '049: Korea Fund Partners ← Mirae Asset Fund Services 905: Shinhan Fund Partners ← Shinhanaitas 906: WOORI FUND SERVICES 2023.04.10 new 907: HANA FUND SERVICES 2024.09.09 new 909: KB FUND PARTNERS 2024'
      - id: name_of_counterparty
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of counterparty'
      - id: otc_derivatives_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0:funded 1:Unfunded'
      - id: net_assets_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Won'
      - id: total_danger_exposure_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Won'
      - id: security_appraisal_amount
        type: str
        size: 15
        encoding: ASCII
        doc: 'Unit:Won'
      - id: security_rate
        type: str
        size: 7
        encoding: ASCII
        doc: '99999V99 Unit:%. Implied decimal with scale 1e-2'
      - id: risk_appraisal_amount
        type: str
        size: 15
        encoding: ASCII
        doc: '단위:원'
      - id: risk_appraisal_amount_rate
        type: str
        size: 7
        encoding: ASCII
        doc: '99999V99 Unit:%. Implied decimal with scale 1e-2'
      - id: filler_38
        type: str
        size: 38
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  synthetic_etf_constituents_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: data_seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Transmission seq. number'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: office_consignment_companys_registration_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '049: Korea Fund Partners ← Mirae Asset Fund Services 905: Shinhan Fund Partners ← Shinhanaitas 906: WOORI FUND SERVICES 2023.04.10 new 907: HANA FUND SERVICES 2024.09.09 new 909: KB FUND PARTNERS 2024'
      - id: composition_constituents_number
        type: str
        size: 4
        encoding: ASCII
        doc: 'Unit: constituents (including cash)'
      - id: composition_constituents_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Standard Code Overseas constituents ''0'' or can set by Space'
      - id: composition_constituents_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of constitution'
      - id: composition_ratio
        type: str
        size: 7
        encoding: ASCII
        doc: 'Composition ratio within Indices 99999V99 Unit:%. Implied decimal with scale 1e-2'
      - id: filler_60
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  elw_investment_indicator_sensitivity_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: time
        type: hhmmss_ascii_time
        doc: 'During market: HHMMSS (Time:min:Sec) 090000 ~ Market Closing: JUNJJJ'
      - id: theoretical_warrant_price
        type: str
        size: 10
        encoding: ASCII
        doc: '9(8)9V9(2). Implied decimal with scale 1e-2'
      - id: sensitivity_delta_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"+", "-", " "'
      - id: sensitivity_delta
        type: str
        size: 7
        encoding: ASCII
        doc: '9V9(6). Implied decimal with scale 1e-6'
      - id: sensitivity_gamma_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"+", "-", " "'
      - id: sensitivity_gamma
        type: str
        size: 7
        encoding: ASCII
        doc: '9V9(6). Implied decimal with scale 1e-6'
      - id: sensitivity_theta_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"+", "-", " "'
      - id: sensitivity_theta
        type: str
        size: 12
        encoding: ASCII
        doc: '9(6)V9(6). Implied decimal with scale 1e-6'
      - id: sensitivity_vega_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"+", "-", " "'
      - id: sensitivity_vega
        type: str
        size: 12
        encoding: ASCII
        doc: '9(6)V9(6). Implied decimal with scale 1e-6'
      - id: sensitivity_rho_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"+", "-", " "'
      - id: sensitivity_rho
        type: str
        size: 12
        encoding: ASCII
        doc: '9(6)V9(6). Implied decimal with scale 1e-6'
      - id: intrinsic_volatility
        type: str
        size: 5
        encoding: ASCII
        doc: '9(3)V9(2) "0" for Early Closed ELW. Implied decimal with scale 1e-2'
      - id: prerequisite_cost
        type: str
        size: 10
        encoding: ASCII
        doc: '9(8)V9(2) "0" for Standard ELW. Implied decimal with scale 1e-2'
      - id: filler_6
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etn_iiv_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: hours
        type: hhmmss_ascii_time
        doc: 'HHMMSS:During Market hours JUNJJJ:Market Closure'
      - id: previous_days_iv
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2). Implied decimal with scale 1e-2'
      - id: during_market_hours_final_iv
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2). Implied decimal with scale 1e-2'
      - id: filler_28
        type: str
        size: 28
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  etn_disparate_ratio_message:
    seq:
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code(ISIN) ISIN ← ETN Symbol Code'
      - id: seq_number
        type: str
        size: 8
        encoding: ASCII
        doc: '1~99999999 Transmission Sequence Number to check number of orders'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'YYYMMDD:Last business day'
      - id: disparate_ratio_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPACE:0, ''+'':>0, ''-'':<0'
      - id: disparate_ratio
        type: str
        size: 9
        encoding: ASCII
        doc: '9(7)V9(2), Unit:%. Implied decimal with scale 1e-2'
      - id: filler_56
        type: str
        size: 56
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  loan_transaction_available_quantity_message:
    seq:
      - id: issue_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Standard Code (ISIN) of the issue. Workbook field name: 종목코드'
      - id: business_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business code identifying the disclosure type. 001 = Loan transaction available quantity public disclosure. Workbook field name: 업무코드'
      - id: available_lending_quantity
        type: str
        size: 10
        encoding: ASCII
        doc: 'Available stock-lending quantity (10 ASCII digits). Workbook field name: 대주가능수량'
      - id: filler_19
        type: str
        size: 19
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF). Workbook field name: 정보분배메세지종료키워드'
  str_12_nullable:
    seq:
      - id: value
        size: 12
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
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
  hhmmssmm_ascii_time:
    seq:
      - id: text
        type: str
        size: 8
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
  str_9_nullable:
    seq:
      - id: value
        size: 9
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
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
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"

enums:
  quotation_category:
    0x30:
      id: 'weighted_average_price'
      doc: 'Weighted Average Price'
    0x31:
      id: 'quotation'
      doc: 'Quotation'
    0x32:
      id: 'no_trade'
      doc: 'No Trade'
  end_keyword:
    255:
      id: 'end_of_message'
      doc: 'End Of Message'
  type_field:
    0x31:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x32:
      id: 'lift_after_trading_halt'
      doc: 'Lift After Trading Halt'
  process_type:
    0x31:
      id: 'normal'
      doc: 'Normal'
    0x32:
      id: 'correction'
      doc: 'Correction'
    0x33:
      id: 'cancellation'
      doc: 'Cancellation'
  bidask_type:
    0x31:
      id: 'ask'
      doc: 'Ask'
    0x32:
      id: 'bid'
      doc: 'Bid'
  compared_to_previous_day_type:
    0x2b:
      id: 'up'
      doc: 'Up'
    0x20:
      id: 'steadiness'
      doc: 'Steadiness'
    0x2d:
      id: 'down'
      doc: 'Down'
  sign:
    0x2b:
      id: 'ascended'
      doc: 'Ascended'
    0x20:
      id: 'steadiness'
      doc: 'Steadiness'
    0x2d:
      id: 'declined'
      doc: 'Declined'

