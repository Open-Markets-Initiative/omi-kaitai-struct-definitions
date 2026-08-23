# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Utp Snapshot Utp v3.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Snapshot
#   Encoding: Utp
#   Version: 3.0
#   Date: 06/01/2026
#   Specification: UTPSnapShotSpec.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_utp_snapshot_utp_v3_0_client
  title: Nasdaq Utp Snapshot Utp v3.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Unlisted Trading Privileges Plan Snapshot Utp v3.0'
doc-ref: https://www.utpplan.com/technical

seq:
  - id: client_tcp_packet_header
    type: client_tcp_packet_header_struct
    doc: 'Packet header of a packet sent by the client'
  - id: client_tcp_payload
    size: client_tcp_packet_header.packet_length + 2 - 3
    type:
      switch-on: client_tcp_packet_header.client_packet_type
      cases:
        'client_packet_type::debug_packet': debug_packet
        'client_packet_type::login_request_packet': login_request_packet

types:
  client_tcp_packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the SoupBinTCP packet not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying the SoupBinTCP packet type sent by the client'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free-form human-readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'The SoupBinTCP login username, left padded with spaces'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'The SoupBinTCP login password, left padded with spaces'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The requested session ID, space-padded; spaces request the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The first sequenced message number the client wishes to receive. For Snap-Shot, must be 1 to receive a full spin'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupBinTCP Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupBinTCP Login Request Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupBinTCP Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupBinTCP Logout Request Packet'
  server_packet_type:
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x2b:
      id: 'debug_packet'
      doc: 'SoupBinTCP Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupBinTCP Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupBinTCP Login Rejected Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupBinTCP Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupBinTCP End of Session Packet'
  market_center_originator:
    0x59:
      id: 'cboe_byx_exchange_inc'
      doc: 'Cboe Byx Exchange Inc'
    0x5a:
      id: 'cboe_bzx_exchange_inc'
      doc: 'Cboe Bzx Exchange Inc'
    0x4a:
      id: 'cboe_edga_exchange_inc'
      doc: 'Cboe Edga Exchange Inc'
    0x4b:
      id: 'cboe_edgx_exchange_inc'
      doc: 'Cboe Edgx Exchange Inc'
    0x57:
      id: 'cboe_exchange_inc'
      doc: 'Cboe Exchange Inc'
    0x42:
      id: 'nasdaq_texas_llc'
      doc: 'Nasdaq Texas Llc'
    0x58:
      id: 'nasdaq_phlx_llc'
      doc: 'Nasdaq Phlx Llc'
    0x51:
      id: 'nasdaq_inc'
      doc: 'Nasdaq Inc'
    0x49:
      id: 'nasdaq_ise_llc'
      doc: 'Nasdaq Ise Llc'
    0x4e:
      id: 'new_york_stock_exchange_llc'
      doc: 'New York Stock Exchange Llc'
    0x50:
      id: 'nyse_arca_inc'
      doc: 'Nyse Arca Inc'
    0x41:
      id: 'nyse_american_llc'
      doc: 'Nyse American Llc'
    0x43:
      id: 'nyse_national_inc'
      doc: 'Nyse National Inc'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x46:
      id: 'texas_stock_exchange_llc'
      doc: 'Texas Stock Exchange Llc'
    0x47:
      id: 'n_24_x_national_exchange_llc'
      doc: 'N 24 X National Exchange Llc'
    0x44:
      id: 'financial_industry_regulatory_authority'
      doc: 'Financial Industry Regulatory Authority'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x48:
      id: 'miax_pearl_llc'
      doc: 'Miax Pearl Llc'
    0x55:
      id: 'memx_llc'
      doc: 'Memx Llc'
    0x45:
      id: 'market_independent_generated_by_sip'
      doc: 'Market Independent Generated By Sip'
  sub_market_center_id:
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x51:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x20:
      id: 'trade_originates_from_finra_alternative_display_facility'
      doc: 'Trade Originates From Finra Alternative Display Facility'
  issue_type:
    0x41:
      id: 'american_depository_receipt'
      doc: 'American Depository Receipt'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x46:
      id: 'depository_receipt'
      doc: 'Depository Receipt'
    0x49:
      id: 'sec_144_a'
      doc: 'Sec 144 A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'note'
      doc: 'Note'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units Of Beneficial Interest'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  market_tier:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
    0x44:
      id: 'demo'
      doc: 'Demo'
    0x58:
      id: 'deleted'
      doc: 'Deleted'
  short_sale_threshold_indicator:
    0x59:
      id: 'issue_is_restricted_under_sec_rule_203_b_3'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'issue_is_not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'threshold_indicator_not_available'
      doc: 'Threshold Indicator Not Available'
  financial_status_indicator:
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x44:
      id: 'deficient_issuer_failed_to_meet_nasdaq_continued_listing_requirements'
      doc: 'Deficient Issuer Failed To Meet Nasdaq Continued Listing Requirements'
    0x45:
      id: 'delinquent_issuer_missed_regulatory_filing_deadline'
      doc: 'Delinquent Issuer Missed Regulatory Filing Deadline'
    0x51:
      id: 'bankrupt_issuer_has_filed_for_bankruptcy'
      doc: 'Bankrupt Issuer Has Filed For Bankruptcy'
    0x4e:
      id: 'normal_default_issuer_is_not_deficient_delinquent_or_bankrupt'
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient And Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient And Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent And Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient Delinquent And Bankrupt'
  mpi_tick:
    0x50:
      id: 'penny_mpi'
      doc: 'Penny Mpi'
    0x48:
      id: 'half_penny_mpi_effective_nov_2026_per_sec_mandate'
      doc: 'Half Penny Mpi Effective Nov 2026 Per Sec Mandate'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_in_effect_due_to_an_intra_day_price_drop_in_security'
      doc: 'Reg Sho In Effect Due To An Intra Day Price Drop In Security'
    0x32:
      id: 'reg_sho_restriction_remains_in_effect'
      doc: 'Reg Sho Restriction Remains In Effect'
  trading_action_code:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption_including_after_ema'
      doc: 'Quotation Resumption Including After Ema'
    0x54:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
    0x50:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
  luld_price_band_indicator:
    0x41:
      id: 'opening_update'
      doc: 'Opening Update'
    0x42:
      id: 'intra_day_update'
      doc: 'Intra Day Update'
    0x43:
      id: 'restated_value'
      doc: 'Restated Value'
    0x44:
      id: 'suspended_during_trading_halt_or_trading_pause'
      doc: 'Suspended During Trading Halt Or Trading Pause'
    0x45:
      id: 're_opening_update'
      doc: 'Re Opening Update'
    0x46:
      id: 'outside_price_band_rule_hours'
      doc: 'Outside Price Band Rule Hours'
    0x20:
      id: 'none_provided'
      doc: 'None Provided'
  quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'nonfirm_quote'
      doc: 'Nonfirm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_twosided_open_quote_automated'
      doc: 'Regular Twosided Open Quote Automated'
    0x55:
      id: 'manual_bid_and_ask_nonfirm'
      doc: 'Manual Bid And Ask Nonfirm'
    0x58:
      id: 'order_influx'
      doc: 'Order Influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated Bid No Offer Or Automated Offer No Bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  sip_generated_update_flag:
    0x20:
      id: 'transaction_originated_from_market_participant'
      doc: 'Transaction Originated From Market Participant'
    0x45:
      id: 'si_pgenerated_transaction_eg_price_band_change'
      doc: 'Si Pgenerated Transaction Eg Price Band Change'
  luld_bbo_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'bid_price_above_upper_limit_price_band_bid_is_non_executable'
      doc: 'Bid Price Above Upper Limit Price Band Bid Is Non Executable'
    0x42:
      id: 'ask_price_below_lower_limit_price_band_ask_is_non_executable'
      doc: 'Ask Price Below Lower Limit Price Band Ask Is Non Executable'
    0x43:
      id: 'bid_and_ask_outside_price_band_not_executable'
      doc: 'Bid And Ask Outside Price Band Not Executable'
  retail_interest_indicator:
    0x20:
      id: 'retail_interest_not_applicable'
      doc: 'Retail Interest Not Applicable'
    0x41:
      id: 'retail_interest_on_bid_quote'
      doc: 'Retail Interest On Bid Quote'
    0x42:
      id: 'retail_interest_on_ask_quote'
      doc: 'Retail Interest On Ask Quote'
    0x43:
      id: 'retail_interest_on_both_bid_and_ask_quote'
      doc: 'Retail Interest On Both Bid And Ask Quote'
  nbbo_appendage_indicator:
    0x30:
      id: 'no_national_bbo_change'
      doc: 'No National Bbo Change'
    0x31:
      id: 'no_national_bbo_can_be_calculated'
      doc: 'No National Bbo Can Be Calculated'
    0x32:
      id: 'short_form_national_bbo_appendage_attached'
      doc: 'Short Form National Bbo Appendage Attached'
    0x33:
      id: 'long_form_national_bbo_appendage_attached'
      doc: 'Long Form National Bbo Appendage Attached'
    0x34:
      id: 'quote_contains_all_national_bbo_information'
      doc: 'Quote Contains All National Bbo Information'
  luld_national_bbo_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'national_best_bid_and_national_best_ask_are_executable'
      doc: 'National Best Bid And National Best Ask Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band_non_executable'
      doc: 'National Best Bid Below Lower Limit Price Band Non Executable'
    0x43:
      id: 'national_best_ask_above_upper_limit_price_band_non_executable'
      doc: 'National Best Ask Above Upper Limit Price Band Non Executable'
    0x44:
      id: 'national_best_bid_below_lower_and_national_best_ask_above_upper_limit_price_bands_non_executable'
      doc: 'National Best Bid Below Lower And National Best Ask Above Upper Limit Price Bands Non Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band_national_best_bid_is_in_limit_state'
      doc: 'National Best Bid Equals Upper Limit Price Band National Best Bid Is In Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band_national_best_ask_is_in_limit_state'
      doc: 'National Best Offer Equals Lower Limit Price Band National Best Ask Is In Limit State'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_in_limit_state_and_national_best_ask_above_upper_limit_price_band_non_executable'
      doc: 'National Best Bid Equals Upper Limit Price Band In Limit State And National Best Ask Above Upper Limit Price Band Non Executable'
    0x48:
      id: 'national_best_ask_equals_lower_limit_price_band_in_limit_state_and_national_best_bid_below_lower_limit_price_band_non_executable'
      doc: 'National Best Ask Equals Lower Limit Price Band In Limit State And National Best Bid Below Lower Limit Price Band Non Executable'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_ask_equals_lower_limit_price_band_crossed_not_in_limit_state'
      doc: 'National Best Bid Equals Upper Limit Price Band And National Best Ask Equals Lower Limit Price Band Crossed Not In Limit State'
  finra_adf_mpid_appendage_indicator:
    0x20:
      id: 'not_applicable_quotation_originates_from_a_utp_participant_other_than_finra'
      doc: 'Not Applicable Quotation Originates From A Utp Participant Other Than Finra'
    0x30:
      id: 'no_adf_mpid_changes_current_adf_quote_does_not_affect_the_finra_mpid'
      doc: 'No Adf Mpid Changes Current Adf Quote Does Not Affect The Finra Mpid'
    0x31:
      id: 'no_adf_mpid_exists_no_calculation_of_the_finra_mpid'
      doc: 'No Adf Mpid Exists No Calculation Of The Finra Mpid'
    0x32:
      id: 'adf_mpi_ds_attached_finra_mpid_was_generated'
      doc: 'Adf Mpi Ds Attached Finra Mpid Was Generated'
  bolo_appendage_indicator:
    0x30:
      id: 'no_bolo_change'
      doc: 'No Bolo Change'
    0x31:
      id: 'no_bolo_can_be_calculated'
      doc: 'No Bolo Can Be Calculated'
    0x32:
      id: 'short_form_bolo_appendage_attached'
      doc: 'Short Form Bolo Appendage Attached'
    0x33:
      id: 'long_form_bolo_appendage_attached'
      doc: 'Long Form Bolo Appendage Attached'
    0x35:
      id: 'mpid_form_bolo_appendage_attached'
      doc: 'Mpid Form Bolo Appendage Attached'
  odd_lot_attachment_type:
    0x30:
      id: 'no_odd_lot_price_levels_attached'
      doc: 'No Odd Lot Price Levels Attached'
    0x32:
      id: 'short_form_odd_lot_price_levels_attached'
      doc: 'Short Form Odd Lot Price Levels Attached'
    0x33:
      id: 'long_form_odd_lot_price_levels_attached'
      doc: 'Long Form Odd Lot Price Levels Attached'
    0x35:
      id: 'mpid_form_odd_lot_price_levels_attached'
      doc: 'Mpid Form Odd Lot Price Levels Attached'

