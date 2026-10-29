# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCd OrderEntry Nnf v6.3
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End
#   Version: 6.3
#   Date: 9/1/2025
#   Specification: TP_CUR_Trimmed_NNF_PROTOCOL_6.3.pdf
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
  id: nse_nsecd_orderentry_nnf_v6_3_server
  title: Nse NseCd OrderEntry Nnf v6.3
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Currency Derivatives Order Entry Nnf v6.3'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: server_message
    type: server_message_struct
    repeat: eos
    doc: 'Nnf interactive message sent by the exchange'

types:
  server_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        size: message_header.message_length - 40
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::system_information_out_message': system_information_out_message
            'transaction_code::partial_system_information_message': partial_system_information_message
            'transaction_code::open_order_report_message': open_order_report_message
            'transaction_code::spread_order_log_report_message': spread_order_log_report_message
            'transaction_code::spread_trade_report_message': spread_trade_report_message
            'transaction_code::board_lot_out_message': board_lot_out_message
            'transaction_code::neg_order_to_bl_message': neg_order_to_bl_message
            'transaction_code::order_mod_out_message': order_mod_out_message
            'transaction_code::order_mod_reject_message': order_mod_reject_message
            'transaction_code::order_cancel_out_message': order_cancel_out_message
            'transaction_code::order_cancel_reject_message': order_cancel_reject_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_mod_confirmation_message': order_mod_confirmation_message
            'transaction_code::order_cancel_confirmation_message': order_cancel_confirmation_message
            'transaction_code::cancel_neg_order_message': cancel_neg_order_message
            'transaction_code::freeze_to_control_message': freeze_to_control_message
            'transaction_code::order_error_message': order_error_message
            'transaction_code::batch_order_cancel_message': batch_order_cancel_message
            'transaction_code::sp_board_lot_out_message': sp_board_lot_out_message
            'transaction_code::twol_board_lot_out_message': twol_board_lot_out_message
            'transaction_code::thrl_board_lot_out_message': thrl_board_lot_out_message
            'transaction_code::sp_order_cancel_out_message': sp_order_cancel_out_message
            'transaction_code::sp_order_mod_out_message': sp_order_mod_out_message
            'transaction_code::sp_order_confirmation_message': sp_order_confirmation_message
            'transaction_code::twol_order_confirmation_message': twol_order_confirmation_message
            'transaction_code::thrl_order_confirmation_message': thrl_order_confirmation_message
            'transaction_code::sp_order_cxl_rej_out_message': sp_order_cxl_rej_out_message
            'transaction_code::sp_order_cxl_confirmation_message': sp_order_cxl_confirmation_message
            'transaction_code::twol_order_cxl_confirmati_message': twol_order_cxl_confirmati_message
            'transaction_code::thrl_order_cxl_confirmati_message': thrl_order_cxl_confirmati_message
            'transaction_code::sp_order_mod_rej_out_message': sp_order_mod_rej_out_message
            'transaction_code::sp_order_mod_con_out_message': sp_order_mod_con_out_message
            'transaction_code::twol_order_error_message': twol_order_error_message
            'transaction_code::thrl_order_error_message': thrl_order_error_message
            'transaction_code::on_stop_notification_message': on_stop_notification_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_cancel_confirm_message': trade_cancel_confirm_message
            'transaction_code::trade_cancel_reject_message': trade_cancel_reject_message
            'transaction_code::trade_modify_reject_message': trade_modify_reject_message
            'transaction_code::trade_error_message': trade_error_message
            'transaction_code::trade_cancel_out_message': trade_cancel_out_message
            'transaction_code::trade_modify_confirm_message': trade_modify_confirm_message
            'transaction_code::sign_on_request_out_message': sign_on_request_out_message
            'transaction_code::sign_off_trader_out_message': sign_off_trader_out_message
            'transaction_code::error_response_out_message': error_response_out_message
            'transaction_code::gr_response_message': gr_response_message
            'transaction_code::giveup_app_confirm_tm_message': giveup_app_confirm_tm_message
            'transaction_code::giveup_rej_confirm_tm_message': giveup_rej_confirm_tm_message
            'transaction_code::user_addr_unlock_confirm_out_message': user_addr_unlock_confirm_out_message
            'transaction_code::user_addr_unlock_approve_out_message': user_addr_unlock_approve_out_message
            'transaction_code::user_addr_unlock_reject_o_message': user_addr_unlock_reject_o_message
            'transaction_code::branch_ord_val_limit_upda_message': branch_ord_val_limit_upda_message
            'transaction_code::user_order_limit_update_out_message': user_order_limit_update_out_message
            'transaction_code::dealer_limit_update_out_message': dealer_limit_update_out_message
            'transaction_code::reset_user_password_out_message': reset_user_password_out_message
            'transaction_code::col_user_status_change_out_message': col_user_status_change_out_message
            'transaction_code::spd_ord_limit_update_out_message': spd_ord_limit_update_out_message
            'transaction_code::update_localdb_header_message': update_localdb_header_message
            'transaction_code::update_localdb_trailer_message': update_localdb_trailer_message
            'transaction_code::bcast_asset_mstr_chg_message': bcast_asset_mstr_chg_message
            'transaction_code::box_sign_on_request_out_message': box_sign_on_request_out_message
            'transaction_code::box_sign_off_message': box_sign_off_message
            'transaction_code::secure_box_registration_re_message': secure_box_registration_re_message
            'transaction_code::secure_box_registration_re_message_23009': secure_box_registration_re_message
  message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of message sent or received'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'First two characters of Symbol when the message carries one'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: error_code
        type: s2
        doc: 'Zero when the request succeeded, otherwise an Error Response follows'
      - id: header_timestamp
        type: s8
        doc: 'Host end field, carrying nanoseconds since midnight 01-Jan-1980 on the transaction codes listed in the appendix'
      - id: time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message reached the gateway'
      - id: message_length
        type: s2
        doc: 'Length of the entire message including the message header'
  system_information_out_message:
    seq:
      - id: st_market_status
        type: st_market_status
        doc: 'ST_MARKET_STATUS'
      - id: st_ex_market_status
        type: st_ex_market_status
        doc: 'ST_EX_MARKET_STATUS'
      - id: st_pl_market_status
        type: st_pl_market_status
        doc: 'ST_PL_MARKET_STATUS'
      - id: update_portfolio
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: c_filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'cFiller'
      - id: market_index
        type: s4
        doc: 'This value will be set to thousand and of no use'
      - id: default_settlement_period_normal
        type: s2
        doc: 'DefaultSettlementPeriod (Normal)'
      - id: default_settlement_period_spot
        type: s2
        doc: 'DefaultSettlementPeriod (Spot)'
      - id: default_settlement_period_auction
        type: s2
        doc: 'DefaultSettlementPeriod (Auction)'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: warning_percent
        type: s2
        doc: 'This field contains the warning percentage. (Refer to Turnover Limit Exceeded or Broker Reactivated in Chapter 9) Note: - If a broker exceeds his turnover by this value in percent, then a warning message is broadcast to all traders'
      - id: volume_freeze_percent
        type: s2
        doc: 'VolumeFreezePercent'
      - id: snap_quote_time
        type: second_timestamp
        doc: 'This field contains the snap quote time. Seconds since Dos epoch'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: board_lot_quantity
        type: s4
        doc: 'This field contains the board lot quantity'
      - id: tick_size
        type: s4
        doc: 'This field contains the tick size'
      - id: maximum_gtc_days
        type: s2
        doc: 'This field contains the maximum number of days after which a Good Till Canceled order will be canceled'
      - id: st_stock_eligible_indicators
        type: st_stock_eligible_indicators
        doc: 'St Stock Eligible Indicators'
      - id: disclosed_quantity_percent_allowed
        type: s2
        doc: 'DisclosedQuantityPercentAllowed'
      - id: risk_free_interest_rate
        type: s4
        doc: 'This field contains the risk free interest rate'
  st_market_status:
    seq:
      - id: normal
        type: s2
        doc: 'Normal'
      - id: oddlot
        type: s2
        doc: 'Oddlot'
      - id: spot
        type: s2
        doc: 'Spot'
      - id: auction
        type: s2
        doc: 'Auction'
  st_ex_market_status:
    seq:
      - id: normal
        type: s2
        doc: 'Normal'
      - id: oddlot
        type: s2
        doc: 'Oddlot'
      - id: spot
        type: s2
        doc: 'Spot'
      - id: auction
        type: s2
        doc: 'Auction'
  st_pl_market_status:
    seq:
      - id: normal
        type: s2
        doc: 'Normal'
      - id: oddlot
        type: s2
        doc: 'Oddlot'
      - id: spot
        type: s2
        doc: 'Spot'
      - id: auction
        type: s2
        doc: 'Auction'
  st_stock_eligible_indicators:
    seq:
      - id: aon
        type: b1
        doc: '1 All Or None'
      - id: minimum_fill
        type: b1
        doc: 'This is not used'
      - id: books_merged
        type: b1
        doc: 'BooksMerged'
      - id: reserved_113
        type: b13
        doc: 'Reserved'
  partial_system_information_message:
    seq:
      - id: st_market_status
        type: st_market_status
        doc: 'ST_MARKET_STATUS'
      - id: st_ex_market_status
        type: st_ex_market_status
        doc: 'ST_EX_MARKET_STATUS'
      - id: st_pl_market_status
        type: st_pl_market_status
        doc: 'ST_PL_MARKET_STATUS'
      - id: update_portfolio
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: c_filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'cFiller'
      - id: market_index
        type: s4
        doc: 'This value will be set to thousand and of no use'
      - id: default_settlement_period_normal
        type: s2
        doc: 'DefaultSettlementPeriod (Normal)'
      - id: default_settlement_period_spot
        type: s2
        doc: 'DefaultSettlementPeriod (Spot)'
      - id: default_settlement_period_auction
        type: s2
        doc: 'DefaultSettlementPeriod (Auction)'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: warning_percent
        type: s2
        doc: 'This field contains the warning percentage. (Refer to Turnover Limit Exceeded or Broker Reactivated in Chapter 9) Note: - If a broker exceeds his turnover by this value in percent, then a warning message is broadcast to all traders'
      - id: volume_freeze_percent
        type: s2
        doc: 'VolumeFreezePercent'
      - id: snap_quote_time
        type: second_timestamp
        doc: 'This field contains the snap quote time. Seconds since Dos epoch'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: board_lot_quantity
        type: s4
        doc: 'This field contains the board lot quantity'
      - id: tick_size
        type: s4
        doc: 'This field contains the tick size'
      - id: maximum_gtc_days
        type: s2
        doc: 'This field contains the maximum number of days after which a Good Till Canceled order will be canceled'
      - id: st_stock_eligible_indicators
        type: st_stock_eligible_indicators
        doc: 'St Stock Eligible Indicators'
      - id: disclosed_quantity_percent_allowed
        type: s2
        doc: 'DisclosedQuantityPercentAllowed'
      - id: risk_free_interest_rate
        type: s4
        doc: 'This field contains the risk free interest rate'
  open_order_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is set to ‘H’ denoting Header'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Set to the report date. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: firm_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'FirmName'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank while sending to the host'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  spread_order_log_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is set to ‘H’ denoting Header'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Set to the report date. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: firm_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'FirmName'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank while sending to the host'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  spread_trade_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field is set to ‘H’ denoting Header'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Set to the report date. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: firm_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'FirmName'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank while sending to the host'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  board_lot_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  contract_desc:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Symbol of the security'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'This field contains the last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_7
        doc: 'This field will contain a valid strike for Options Contract and for Futures Contract it will be -1. Implied decimal with scale 1e-7'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the OptionType identifier'
      - id: ca_level
        type: s2
        doc: 'This field should contain the Corporate Action Level'
  st_order_flags:
    seq:
      - id: ato
        type: b1
        doc: '1 Market order in Preopen'
      - id: market
        type: b1
        doc: '0 Market order'
      - id: sl
        type: b1
        doc: '1 Stop Loss'
      - id: mit
        type: b1
        doc: '1 Market If Touched'
      - id: day
        type: b1
        doc: '1 Day (This is the default attribute)'
      - id: gtc
        type: b1
        doc: '1 Good Till Cancel'
      - id: ioc
        type: b1
        doc: '1 Immediate Or Cancel'
      - id: aon
        type: b1
        doc: '1 All Or None'
      - id: mf
        type: b1
        doc: '1 Minimum Fill'
      - id: matched_ind
        type: b1
        doc: '1 NT order has found a matching order'
      - id: traded
        type: b1
        doc: '1 The order has been traded partially or fully Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: modified
        type: b1
        doc: '1 The order has to be modified'
      - id: frozen
        type: b1
        doc: '1 The order has gone for a freeze'
      - id: reserved_13
        type: b3
        doc: 'Reserved'
  additional_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: additional_order_flags_reserved_1
        type: b1
        doc: 'Reserved'
      - id: col
        type: b1
        doc: '1 Cancel on Logoff'
      - id: additional_order_flags_reserved_3
        type: b1
        doc: 'Reserved'
      - id: additional_order_flags_reserved_4
        type: b1
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: '0 Cancel order resulting in self trade as per default action by the exchange'
      - id: additional_order_flags_reserved_68
        type: b3
        doc: 'Reserved'
  neg_order_to_bl_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_mod_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_mod_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_cancel_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_cancel_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_mod_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_cancel_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  cancel_neg_order_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  freeze_to_control_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  order_error_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  batch_order_cancel_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable for Regular Lot Orders'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Modified/CancelledBy'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'CounterPartyBrokerId'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: order_type
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: total_volume_remaining
        type: s4
        doc: 'TotalVolumeRemaining'
      - id: volume
        type: s4
        doc: 'This field should contain the order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: trigger_price
        type: decimal_s4_7
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-7'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'MinimumFill / AONVolume'
      - id: last_modified
        type: s4
        doc: 'Value of the Last modified time stamp as received on last transaction response'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should specify the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        doc: 'Pro / ClientIndicator'
      - id: settlement_period
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The front-end may use this field at their discretion'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  sp_board_lot_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  ms_spd_leg_info_leg_2:
    seq:
      - id: token_2
        type: s4
        doc: 'Token number of leg 2 contract of the spread combination'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_2
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId2'
      - id: fillerx_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx2'
      - id: order_type_2
        type: s2
        doc: 'OrderType2'
      - id: buy_sell_2
        type: s2
        doc: 'BuySell2'
      - id: disclosed_vol_2
        type: s4
        doc: 'DisclosedVol2'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'DisclosedVolRemaining2'
      - id: total_vol_remaining_2
        type: s4
        doc: 'TotalVolRemaining2'
      - id: volume_2
        type: s4
        doc: 'This field should contain the quantity of order placed'
      - id: volume_filled_today_2
        type: s4
        doc: 'This is not used'
      - id: price_2
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_2
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: min_fill_aon_2
        type: s4
        doc: 'MinFillAon2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: open_close_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose2'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: filler_y
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerY'
  ms_spd_leg_info_leg_3:
    seq:
      - id: token_2
        type: s4
        doc: 'Token number of leg 2 contract of the spread combination'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_2
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId2'
      - id: fillerx_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx2'
      - id: order_type_2
        type: s2
        doc: 'OrderType2'
      - id: buy_sell_2
        type: s2
        doc: 'BuySell2'
      - id: disclosed_vol_2
        type: s4
        doc: 'DisclosedVol2'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'DisclosedVolRemaining2'
      - id: total_vol_remaining_2
        type: s4
        doc: 'TotalVolRemaining2'
      - id: volume_2
        type: s4
        doc: 'This field should contain the quantity of order placed'
      - id: volume_filled_today_2
        type: s4
        doc: 'This is not used'
      - id: price_2
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_2
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: min_fill_aon_2
        type: s4
        doc: 'MinFillAon2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: open_close_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose2'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: filler_y
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerY'
  twol_board_lot_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_board_lot_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_cancel_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_mod_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_confirmation_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_confirmation_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_confirmation_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_cxl_rej_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_cxl_confirmation_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_cxl_confirmati_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_cxl_confirmati_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_mod_rej_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_order_mod_con_out_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_error_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_error_message:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This is not used'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler1'
      - id: competitor_period_1
        type: s2
        doc: 'This is not used'
      - id: solicitor_period_1
        type: s2
        doc: 'This is not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ModCxlBy1'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler9'
      - id: reason_code_1
        type: s2
        doc: 'This is not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of leg 1 contract of the spread combination Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpBrokerId1'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillerx1'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'FillerOptions1'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Fillery1'
      - id: order_type_1
        type: s2
        doc: 'This field should be set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'This field should be set to blank for the order entry request'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number is specified in this field'
      - id: book_type_1
        type: s2
        doc: 'This field should contain one of the following two book types. ‘1’ – Regular lot order ‘2’ – Special terms order'
      - id: buy_sell_1
        type: s2
        doc: 'BuySell1'
      - id: disclosed_vol_1
        type: s4
        doc: 'DisclosedVol1'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'DisclosedVolRemaining1'
      - id: total_vol_remaining_1
        type: s4
        doc: 'TotalVolRemaining1'
      - id: volume_1
        type: s4
        doc: 'This field should contain the quantity for which the order is placed'
      - id: volume_filled_today_1
        type: s4
        doc: 'This is not used'
      - id: price_1
        type: decimal_s4_7
        doc: 'For spread order this is not used. Implied decimal with scale 1e-7'
      - id: trigger_price_1
        type: decimal_s4_7
        doc: 'This is not used. Implied decimal with scale 1e-7'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'This is not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'This field contains the time when the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'MinFillAon1'
      - id: last_modified_1
        type: s4
        doc: 'LastModified1'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: branch_id_1
        type: s2
        doc: 'This field should contain the Branch Number to which the broker belongs'
      - id: trader_id_1
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'cOrdFiller'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'OpenClose1'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client_1
        type: s2
        doc: 'ProClient1'
      - id: settlement_period_1
        type: s2
        doc: 'This field should contain the number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler17'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler18'
      - id: nnf_field
        type: floating_point_integer
        doc: 'NnfField'
      - id: mkt_replay
        type: s8
        doc: 'This field should be set to zero while sending message to the host'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
      - id: price_diff
        type: decimal_s4_7
        doc: 'This is the difference between the prices at which leg2 and leg1 should trade and just like normal price this also should be multiple of tick size and within the price range and must be multiplied by 10000000. Implied decimal with scale 1e-7'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  on_stop_notification_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  trade_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  trade_cancel_confirm_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  trade_cancel_reject_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  trade_modify_reject_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  trade_error_message:
    seq:
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: mkt_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MktType'
      - id: buy_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to ‘O‘for Open or ‘C‘for Close for Buy trade'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'BuyBrokerId'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'SellBrokerId'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: requested_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates which side (Buy/Sell) of the trade is to be modified/cancelled'
      - id: sell_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the Open / Close indicator for the Sell trade'
      - id: buy_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'BuyAccountNumber'
      - id: sell_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'SellAccountNumber'
      - id: reserved_24
        size: 24
        doc: 'Reserved field'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: buy_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: sell_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: reserved_60
        size: 60
        doc: 'Reserved field'
  trade_cancel_out_message:
    seq:
      - id: token_no
        type: s4
        doc: 'This is the Token Number of the contract for which this order was originally placed'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: mkt_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MktType'
      - id: buy_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to ‘O‘for Open or ‘C‘for Close for Buy trade'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'BuyBrokerId'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'SellBrokerId'
      - id: trader_id
        type: s4
        doc: 'This field should contain the trader ID'
      - id: requested_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field indicates which side (Buy/Sell) of the trade is to be modified/cancelled'
      - id: sell_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the Open / Close indicator for the Sell trade'
      - id: buy_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'BuyAccountNumber'
      - id: sell_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'SellAccountNumber'
      - id: reserved_24
        size: 24
        doc: 'Reserved field'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: second_reserved_2
        size: 2
        doc: 'Reserved field'
      - id: buy_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: sell_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: reserved_60
        size: 60
        doc: 'Reserved field'
  trade_modify_confirm_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'ResponseOrderNumber'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: trader_number
        type: s4
        doc: 'TraderNumber This field contains the trader or user ID'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the Trader Account Number should be specified in this field'
      - id: buy_sell_indicator
        type: s2
        doc: 'Buy/SellIndicator'
      - id: original_volume
        type: s4
        doc: 'OriginalVolume This field contains the original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'This field should contain the quantity that has to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'DisclosedVolumeRemaining'
      - id: price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-7'
      - id: st_order_flags
        type: st_order_flags
        doc: 'St Order Flags'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'This field should contain the number of days for a GTD order. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_quantity
        type: s4
        doc: 'This field should contain the quantity that has been traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: volume_filled_today
        type: s4
        doc: 'VolumeFilledToday'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains one of the following values to denote the activity type. • ‘B’ for Buy • ‘S’ for Sell'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity has taken place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'CounterTraderOrderNumber'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Trading Member ID of the counter party taking part in the trade'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For trade confirmation both Open Close and Old Open Close fields are same'
      - id: book_type_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the type of order'
      - id: third_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'OldAccountNumber'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the participant id same as that of original trade confirmation message'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Refer to Additional_Order_Flags and Order Terms Attributes tables in Chapter 4 for the relevant description'
      - id: fourth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: fifth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: sixth_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trade modification this field shall contain the old PAN else it will be blank'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
      - id: last_activity_reference
        type: s8
        doc: 'In case of order entry response, this field will contain a unique value'
      - id: reserved_52
        size: 52
        doc: 'Reserved field'
  sign_on_request_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_8
        size: 8
        doc: 'Reserved field'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The password should be of exact eight characters in length.The password should be alphanumeric i.e password should contain 1 upper case letter,1 lower case letter,1 numeral and 1 special character from the list @#$%&*/\. Note: The trader sh'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved field'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be entered only when the trader wishes to change the password or the password has expired'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank while sending to the host'
      - id: last_password_change_date
        type: dos_second_timestamp
        doc: 'LastPasswordChangeDate. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: version_number
        type: s4
        doc: 'This field should contain the version number of the trading system'
      - id: batch_2_start_time
        type: dos_second_timestamp
        doc: 'This field should be set to numerical zero. Seconds since Dos epoch'
      - id: host_switch_context
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: colour
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: sequence_number
        type: floating_point_integer
        doc: 'This field should be set to numerical zero while sending the request to host'
      - id: ws_class_name
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'WsClassName'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: show_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: st_broker_eligibility_per_mkt
        type: st_broker_eligibility_per_mkt
        doc: 'St Broker Eligibility Per Mkt'
      - id: member_type
        type: s2
        doc: 'This field should be set to numerical zero'
      - id: clearing_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the broker’s name'
      - id: reserved_16
        size: 16
        doc: 'Reserved field'
      - id: second_reserved_16
        size: 16
        doc: 'Reserved field'
      - id: third_reserved_16
        size: 16
        doc: 'Reserved field'
  st_broker_eligibility_per_mkt:
    seq:
      - id: normal_market
        type: b1
        doc: 'Normal Market'
      - id: auction_market
        type: b1
        doc: 'Auction Market'
      - id: spot_market
        type: b1
        doc: 'Spot Market'
      - id: oddlot_market
        type: b1
        doc: 'Oddlot Market'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  sign_off_trader_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_8
        size: 8
        doc: 'Reserved field'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The password should be of exact eight characters in length.The password should be alphanumeric i.e password should contain 1 upper case letter,1 lower case letter,1 numeral and 1 special character from the list @#$%&*/\. Note: The trader sh'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved field'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be entered only when the trader wishes to change the password or the password has expired'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank while sending to the host'
      - id: last_password_change_date
        type: dos_second_timestamp
        doc: 'LastPasswordChangeDate. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: version_number
        type: s4
        doc: 'This field should contain the version number of the trading system'
      - id: batch_2_start_time
        type: dos_second_timestamp
        doc: 'This field should be set to numerical zero. Seconds since Dos epoch'
      - id: host_switch_context
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: colour
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: sequence_number
        type: floating_point_integer
        doc: 'This field should be set to numerical zero while sending the request to host'
      - id: ws_class_name
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'WsClassName'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: show_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: st_broker_eligibility_per_mkt
        type: st_broker_eligibility_per_mkt
        doc: 'St Broker Eligibility Per Mkt'
      - id: member_type
        type: s2
        doc: 'This field should be set to numerical zero'
      - id: clearing_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the broker’s name'
      - id: reserved_16
        size: 16
        doc: 'Reserved field'
      - id: second_reserved_16
        size: 16
        doc: 'Reserved field'
      - id: third_reserved_16
        size: 16
        doc: 'Reserved field'
  error_response_out_message:
    seq:
      - id: key
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the token number of the Contract'
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the error message'
  gr_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: ip_address
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'IP address assigned by exchange'
      - id: port
        type: s4
        doc: 'Port Number given by exchange'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session key to be used for authentication'
      - id: cryptographic_key
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cryptographic key for both the encryption and decryption of all messages between member application and allocated Gateway Server'
      - id: cryptographic_iv
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cryptographic IV (Initialization Vector) for both the encryption (Initialization and decryption of all messages between member application Vector) and allocated Gateway Server'
  giveup_app_confirm_tm_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: giveup
        type: giveup
        doc: 'GIVEUP'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  giveup:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'This field must be sent as blank for the order entry request'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Symbol of the security'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'This field contains the last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_7
        doc: 'This field will contain a valid strike for Options Contract and for Futures Contract it will be -1. Implied decimal with scale 1e-7'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the OptionType identifier'
      - id: ca_level
        type: s2
        doc: 'This field should contain the Corporate Action Level'
      - id: fill_volume
        type: s4
        doc: 'This field contains the quantity of security traded'
      - id: fill_price
        type: decimal_s4_7
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-7'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: buy_sell
        type: s2
        doc: 'This field should contain one of the following values to specify whether the order is a buy or sell order. ‘1’ denotes Buy order ‘2’ denotes Sell order Note: - Must follow same rules as mentioned in Order Modification section in Currency NN'
      - id: book_type_short_2
        type: s2
        doc: 'This field should contain the type of order'
      - id: last_modified_date_time
        type: dos_second_timestamp
        doc: 'LastModifiedDateTime. Seconds since Dos epoch'
      - id: initiated_by_control
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'InitiatedByControl'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'No NA'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain Give up flag'
      - id: deleted
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Host should send N is this field'
  giveup_rej_confirm_tm_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order freeze'
      - id: giveup
        type: giveup
        doc: 'GIVEUP'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  user_addr_unlock_confirm_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_36
        size: 36
        doc: 'Reserved field'
  user_addr_unlock_approve_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_36
        size: 36
        doc: 'Reserved field'
  user_addr_unlock_reject_o_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_36
        size: 36
        doc: 'Reserved field'
  branch_ord_val_limit_upda_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_25
        size: 25
        doc: 'Reserved field'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: branch_limits_1
        type: branch_limits_1
        doc: 'BRANCH_LIMITS 1'
      - id: branch_limits_2
        type: branch_limits_2
        doc: 'BRANCH_LIMITS 2'
  branch_limits_1:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch buy limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch sell limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: reserved_16
        size: 16
        doc: 'Reserved field'
  branch_limits_2:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch buy limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch sell limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: reserved_16
        size: 16
        doc: 'Reserved field'
  user_order_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: user_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the name of user'
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: user_type
        type: s2
        doc: 'This field can take one of the following values. • ‘0’ denotes Dealer • ‘4’ denotes Corporate Manager • ‘5’ denotes Branch Manager This field should be set to zero while sending to the host'
      - id: instrument_user
        type: instrument_user
        doc: 'INSTRUMENT_USER'
      - id: reserved_64
        size: 64
        doc: 'Padding to the declared packet length'
  instrument_user:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch buy limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'This field should contain branch sell limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: branch_used_buy_value_limit
        type: floating_point_integer
        doc: 'BranchUsedBuyValueLimit'
      - id: branch_used_sell_value_limit
        type: floating_point_integer
        doc: 'BranchUsedSellValueLimit'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'This field should contain user buy limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'This field should contain user sell limit to be set (in lakhs) Valid values: 0 to 99999999999.99 This should be multiplied by (100000*10000000) before sending to the trading system'
      - id: user_order_used_buy_value_limit
        type: floating_point_integer
        doc: 'UserOrderUsedBuyValueLimit'
      - id: user_order_used_sell_value_limit
        type: floating_point_integer
        doc: 'UserOrderUsedSellValueLimit'
  dealer_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: ord_qty_buff
        type: floating_point_integer
        doc: 'This field contains the maximum Order quantity which user can enter while order entry'
      - id: ord_val_buff
        type: floating_point_integer
        doc: 'This field contains the maximum order value which user can enter while order entry'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  reset_user_password_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: reserved_14
        size: 14
        doc: 'Reserved field'
  col_user_status_change_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: col_user_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain user’s COL status to be set'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  spd_ord_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: user_id
        type: s4
        doc: 'UserID'
      - id: spd_ord_qty_buff
        type: floating_point_integer
        doc: 'This field contains the maximum Order quantity which user can enter while spread order entry'
      - id: spd_ord_val_buff
        type: floating_point_integer
        doc: 'This field contains the maximum order value which user can enter while spread order entry'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
  update_localdb_header_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
  update_localdb_trailer_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved field'
  bcast_asset_mstr_chg_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'This field contains the number of records sent for updation'
      - id: asset_details
        type: asset_details
        doc: 'ASSET_DETAILS'
      - id: reserved_364
        size: 364
        doc: 'Padding to the declared packet length'
  asset_details:
    seq:
      - id: asset_name
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the name of the asset'
      - id: precision
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the digits after decimal to be allowed for all price related fields for the contracts on this Asset'
      - id: reserved_1
        size: 1
        doc: 'Padding to the declared packet length'
      - id: volatility
        type: s4
        doc: 'This field contains value of volatility'
      - id: token
        type: s4
        doc: 'This field contains the token number of the Asset'
      - id: multiplier
        type: s4
        doc: 'This field contains the value by which each lot of the contract over this symbol is multiplied to get actual quantity of the request'
      - id: foreign_interest_rate
        type: s2
        doc: 'This field contains value of foreign interest rate'
  box_sign_on_request_out_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
      - id: reserved_10
        size: 10
        doc: 'Reserved field'
  box_sign_off_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
  secure_box_registration_re_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
  dos_second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      unix_seconds:
        value: time + 315532800
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  second_timestamp:
    seq:
      - id: time
        type: s2
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  decimal_s4_7:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000000.0
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>

enums:
  transaction_code:
    1600:
      id: 'system_information_in_message'
      doc: '1600 MS_SYSTEM_INFO_REQ 44 I, carried in the MS_SYSTEM_INFO_REQ structure'
    1601:
      id: 'system_information_out_message'
      doc: '1601 MS_SYSTEM_INFO_DATA 106 I, carried in the MS_SYSTEM_INFO_DATA structure'
    7321:
      id: 'partial_system_information_message'
      doc: '7321 MS_SYSTEM_INFO_DATA 106 I Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End, carried in the MS_SYSTEM_INFO_DATA structure'
    1821:
      id: 'open_order_report_message'
      doc: '1821 MS_RP_HDR 108 I, carried in the MS_RP_HDR structure'
    1992:
      id: 'spread_order_log_report_message'
      doc: '1992 MS_RP_HDR 108 I, carried in the MS_RP_HDR structure'
    1993:
      id: 'spread_trade_report_message'
      doc: '1993 MS_RP_HDR 108 I, carried in the MS_RP_HDR structure'
    2000:
      id: 'board_lot_in_message'
      doc: '2000 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2001:
      id: 'board_lot_out_message'
      doc: '2001 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2008:
      id: 'neg_order_to_bl_message'
      doc: '2008 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2040:
      id: 'order_mod_in_message'
      doc: '2040 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2041:
      id: 'order_mod_out_message'
      doc: '2041 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2042:
      id: 'order_mod_reject_message'
      doc: '2042 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2070:
      id: 'order_cancel_in_message'
      doc: '2070 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2071:
      id: 'order_cancel_out_message'
      doc: '2071 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2072:
      id: 'order_cancel_reject_message'
      doc: '2072 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2073:
      id: 'order_confirmation_message'
      doc: '2073 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2074:
      id: 'order_mod_confirmation_message'
      doc: '2074 MS_OE_REQUEST 316 I Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End, carried in the MS_OE_REQUEST structure'
    2075:
      id: 'order_cancel_confirmation_message'
      doc: '2075 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2076:
      id: 'cancel_neg_order_message'
      doc: '2076 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2170:
      id: 'freeze_to_control_message'
      doc: '2170 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2231:
      id: 'order_error_message'
      doc: '2231 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    9002:
      id: 'batch_order_cancel_message'
      doc: '9002 MS_OE_REQUEST 316 I, carried in the MS_OE_REQUEST structure'
    2013:
      id: 'price_mod_in_message'
      doc: '2013 PRICE_MOD 106 I, carried in the PRICE_MOD structure'
    2100:
      id: 'sp_board_lot_in_message'
      doc: '2100 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2101:
      id: 'sp_board_lot_out_message'
      doc: '2101 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2102:
      id: 'twol_board_lot_in_message'
      doc: '2102 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2103:
      id: 'twol_board_lot_out_message'
      doc: '2103 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2104:
      id: 'thrl_board_lot_in_message'
      doc: '2104 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2105:
      id: 'thrl_board_lot_out_message'
      doc: '2105 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2106:
      id: 'sp_order_cancel_in_message'
      doc: '2106 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2107:
      id: 'sp_order_cancel_out_message'
      doc: '2107 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2118:
      id: 'sp_order_mod_in_message'
      doc: '2118 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2119:
      id: 'sp_order_mod_out_message'
      doc: '2119 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2124:
      id: 'sp_order_confirmation_message'
      doc: '2124 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2125:
      id: 'twol_order_confirmation_message'
      doc: '2125 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2126:
      id: 'thrl_order_confirmation_message'
      doc: '2126 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2127:
      id: 'sp_order_cxl_rej_out_message'
      doc: '2127 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2130:
      id: 'sp_order_cxl_confirmation_message'
      doc: '2130 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2131:
      id: 'twol_order_cxl_confirmati_message'
      doc: '2131 MS_SPD_OE_REQUEST 480 I ON, carried in the MS_SPD_OE_REQUEST structure'
    2132:
      id: 'thrl_order_cxl_confirmati_message'
      doc: '2132 MS_SPD_OE_REQUEST 480 I ON Confidential Currency Derivatives Trading System - Protocol for Non-Neat Front End, carried in the MS_SPD_OE_REQUEST structure'
    2133:
      id: 'sp_order_mod_rej_out_message'
      doc: '2133 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2136:
      id: 'sp_order_mod_con_out_message'
      doc: '2136 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2155:
      id: 'twol_order_error_message'
      doc: '2155 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2156:
      id: 'thrl_order_error_message'
      doc: '2156 MS_SPD_OE_REQUEST 480 I, carried in the MS_SPD_OE_REQUEST structure'
    2212:
      id: 'on_stop_notification_message'
      doc: '2212 MS_TRADE_CONFIRM 296 I, carried in the MS_TRADE_CONFIRM structure'
    2222:
      id: 'trade_confirmation_message'
      doc: '2222 MS_TRADE_CONFIRM 296 I, carried in the MS_TRADE_CONFIRM structure'
    2282:
      id: 'trade_cancel_confirm_message'
      doc: '2282 MS_TRADE_CONFIRM 296 I, carried in the MS_TRADE_CONFIRM structure'
    2286:
      id: 'trade_cancel_reject_message'
      doc: '2286 MS_TRADE_CONFIRM 296 I, carried in the MS_TRADE_CONFIRM structure'
    2288:
      id: 'trade_modify_reject_message'
      doc: '2288 MS_TRADE_CONFIRM 296 I, carried in the MS_TRADE_CONFIRM structure'
    2223:
      id: 'trade_error_message'
      doc: '2223 MS_TRADE_INQ_DATA 234 I, carried in the MS_TRADE_INQ_DATA structure'
    5440:
      id: 'trade_cancel_in_message'
      doc: '5440 MS_TRADE_INQ_DATA 234 I, carried in the MS_TRADE_INQ_DATA structure'
    5441:
      id: 'trade_cancel_out_message'
      doc: '5441 MS_TRADE_INQ_DATA 234 I, carried in the MS_TRADE_INQ_DATA structure'
    5445:
      id: 'trade_mod_in_message'
      doc: '5445 MS_TRADE_INQ_DATA 234 I, carried in the MS_TRADE_INQ_DATA structure'
    2287:
      id: 'trade_modify_confirm_message'
      doc: '2287 MS_TRADE_MODIFY_CONFIRM 296 I, carried in the MS_TRADE_MODIFY_CONFIRM structure'
    2300:
      id: 'sign_on_request_in_message'
      doc: '2300 MS_SIGNON 278 I, carried in the MS_SIGNON structure'
    2301:
      id: 'sign_on_request_out_message'
      doc: '2301 MS_SIGNON 278 I, carried in the MS_SIGNON structure'
    5584:
      id: 'sign_off_trader_in_message'
      doc: '5584 MS_SIGNON 278 I, carried in the MS_SIGNON structure'
    5585:
      id: 'sign_off_trader_out_message'
      doc: '5585 MS_SIGNON 278 I, carried in the MS_SIGNON structure'
    2302:
      id: 'error_response_out_message'
      doc: '2302 MS_ERROR_RESPONSE 182 I, carried in the MS_ERROR_RESPONSE structure'
    2400:
      id: 'gr_request_message'
      doc: '2400 MS_GR_REQUEST 48 I, carried in the MS_GR_REQUEST structure'
    2401:
      id: 'gr_response_message'
      doc: '2401 MS_GR_RESPONSE 124 I, carried in the MS_GR_RESPONSE structure'
    4506:
      id: 'giveup_app_confirm_tm_message'
      doc: '4506 GIVEUP_RESPONSE 122 I, carried in the GIVEUP_RESPONSE structure'
    4507:
      id: 'giveup_rej_confirm_tm_message'
      doc: '4507 GIVEUP_RESPONSE 122 I, carried in the GIVEUP_RESPONSE structure'
    5427:
      id: 'user_addr_unlock_in_message'
      doc: '5427 USER_ADDR_UNLOCK_REQ_FO 114 I, carried in the USER_ADDR_UNLOCK_REQ_FO structure'
    5428:
      id: 'user_addr_unlock_confirm_out_message'
      doc: 'User Addr Unlock Confirm Out, carried in the USER_ADDR_UNLOCK_CONFIRM_FO structure'
    5483:
      id: 'user_addr_unlock_approve_out_message'
      doc: 'User Addr Unlock Approve Out, carried in the USER_ADDR_UNLOCK_APPROVE_FO structure'
    5484:
      id: 'user_addr_unlock_reject_o_message'
      doc: '5484 USER_ADDR_UNLOCK_APPROVE 76 I, carried in the USER_ADDR_UNLOCK_APPROVE_FO structure'
    5716:
      id: 'branch_ord_val_limit_update_in_message'
      doc: 'Branch Ord Val Limit Update In, carried in the BRANCH_ORD_VAL_LIMIT_UPDATE_REQ structure'
    5717:
      id: 'branch_ord_val_limit_upda_message'
      doc: '5716 BRANCH_ORD_VAL_LIMIT_UPD 136 I, carried in the BRANCH_ORD_VAL_LIMIT_UPDATE_REQ structure'
    5730:
      id: 'user_ord_val_limit_update_in_message'
      doc: 'User Ord Val Limit Update In, carried in the USER_ORD_VAL_LIMIT_UPDATE_REQ structure'
    5731:
      id: 'user_order_limit_update_out_message'
      doc: 'User Order Limit Update Out, carried in the MS_ORDER_VAL_LIMIT_DATA structure'
    5732:
      id: 'normal_ord_limit_update_in_message'
      doc: 'Normal Ord Limit Update In, carried in the NORMAL_ORD_LIMIT_UPDATE_REQ structure'
    5771:
      id: 'spread_ord_limit_update_in_message'
      doc: '5771 NORMAL_ORD_LIMIT_UPDATE_ 66 I REQ, carried in the NORMAL_ORD_LIMIT_UPDATE_REQ structure'
    5733:
      id: 'dealer_limit_update_out_message'
      doc: 'Dealer Limit Update Out, carried in the DEALER_ORD_LMT structure'
    5740:
      id: 'reset_user_password_in_message'
      doc: '5740 RESET_USER_PASSWORD_IN_F 58 I O, carried in the RESET_USER_PASSWORD_IN_FO structure'
    5741:
      id: 'reset_user_password_out_message'
      doc: '5741 RESET_USER_PASSWORD_IN_F 58 I O, carried in the RESET_USER_PASSWORD_IN_FO structure'
    5744:
      id: 'col_user_status_change_in_message'
      doc: '5744 COL_USER_STATUS_CHANGE_R 52 I EQ, carried in the COL_USER_STATUS_CHANGE_REQ structure'
    5745:
      id: 'col_user_status_change_out_message'
      doc: 'Col User Status Change Out, carried in the COL_USER_STATUS_CHANGE_RESP structure'
    5772:
      id: 'spd_ord_limit_update_out_message'
      doc: 'Spd Ord Limit Update Out, carried in the SPD_ORD_LMT structure'
    7000:
      id: 'download_request_message'
      doc: '7000 MS_MESSAGE_DOWNLOAD 48 I, carried in the MS_MESSAGE_DOWNLOAD structure'
    7011:
      id: 'header_record_message'
      doc: '7011 MESSAGE_HEADER 40 I, carried in the MESSAGE_HEADER structure'
    7021:
      id: 'message_record_message'
      doc: '7021 MESSAGE_HEADER 40 I, carried in the MESSAGE_HEADER structure'
    7031:
      id: 'trailer_record_message'
      doc: '7031 MESSAGE_HEADER 40 I, carried in the MESSAGE_HEADER structure'
    7300:
      id: 'update_localdb_in_message'
      doc: '7300 MS_UPDATE_LOCAL_DATABASE 82 I, carried in the MS_UPDATE_LOCAL_DATABASE structure'
    7307:
      id: 'update_localdb_header_message'
      doc: '7307 UPDATE_LDB_HEADER 42 I, carried in the UPDATE_LDB_HEADER structure'
    7308:
      id: 'update_localdb_trailer_message'
      doc: '7308 UPDATE_LDB_HEADER 42 I, carried in the UPDATE_LOCALDB_TRAILER structure'
    7325:
      id: 'bcast_asset_mstr_chg_message'
      doc: 'Bcast Asset Mstr Chg, carried in the MS_DOWNLOAD_ASSET structure'
    23000:
      id: 'box_sign_on_request_in_message'
      doc: '23000 MS_BOX_SIGN_ON_REQUEST_I 60 I N, carried in the MS_BOX_SIGN_ON_REQUEST_IN structure'
    23001:
      id: 'box_sign_on_request_out_message'
      doc: '23001 MS_BOX_SIGN_ON_REQUEST_O 54 I UT, carried in the MS_BOX_SIGN_ON_REQUEST_OUT structure'
    20322:
      id: 'box_sign_off_message'
      doc: '20322 MS_BOX_SIGN_OFF 42 I, carried in the MS_BOX_SIGN_OFF structure'
    23008:
      id: 'secure_box_registration_re_message'
      doc: '23008 MS_SECURE_BOX_REGISTRATI 42 I, carried in the MS_SECURE_BOX_REGISTRATION_REQUEST_IN structure'
    23009:
      id: 'secure_box_registration_re_message_23009'
      doc: '23008 MS_SECURE_BOX_REGISTRATI 42 I, carried in the MS_SECURE_BOX_REGISTRATION_REQUEST_IN structure'

