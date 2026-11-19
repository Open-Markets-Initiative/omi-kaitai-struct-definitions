# ---------------------------------------------------------------------
# Kaitai struct definition for: Nairobi NairobiBonds MarketData Mits v2.14
#
# Protocol:
#   Organization: Nairobi Securities Exchange
#   Protocol: Nairobi Bonds Market Data
#   Encoding: MITS Exchange System
#   Version: 2.14
#   Date: 08/21/2019
#   Specification: Bonds-and-Derrivatives-MITS-Market-Data-API.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: nairobi_nairobibonds_marketdata_mits_v2_14_client
  title: Nairobi NairobiBonds MarketData Mits v2.14
  license: MIT-0
  endian: le

doc: 'Nairobi Securities Exchange Nairobi Securities Exchange Bonds Nairobi Bonds Market Data Mits v2.14'
doc-ref: https://www.nse.co.ke/dataservices/api-specification-documents/

seq:
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'Mits message packet sent by the user'

types:
  client_message_struct:
    seq:
      - id: transport_header
        type: transport_header
        doc: 'Table 1: Transport Header'
      - id: client_message_header
        type: client_message_header
        doc: 'Table 2: Message Header'
      - id: client_message_payload
        size: transport_header.message_length + 4 - 33
        type:
          switch-on: client_message_header.client_message_type
          cases:
            'client_message_type::log_in_message': log_in_message
            'client_message_type::re_request_message': re_request_message
            'client_message_type::request_data_retrieval_message': request_data_retrieval_message
            'client_message_type::request_data_retrieval_message_37': request_data_retrieval_message
            'client_message_type::unsubscribe_contract_message': unsubscribe_contract_message
            'client_message_type::request_daily_trend_message': request_daily_trend_message
            'client_message_type::option_contract_subscription_message': option_contract_subscription_message
            'client_message_type::subscribing_to_indices_service_message': subscribing_to_indices_service_message
            'client_message_type::future_contract_subscription_message': future_contract_subscription_message
            'client_message_type::option_statistics_request_message': option_statistics_request_message
  transport_header:
    seq:
      - id: start_byte
        type: u1
        doc: '255 or FF'
      - id: message_length
        type: u2
        doc: 'Message length, not including the 4 byte transport header'
      - id: length_check
        type: u1
        doc: 'XOR of bytes 2 and 3'
  client_message_header:
    seq:
      - id: sequence_number
        type: s4
        doc: 'Sequence number'
      - id: user_name
        type: user_name
        doc: 'User name as assigned by the exchange'
      - id: user_number
        type: s4
        doc: 'Any user integer, kept by the system and returned unchanged'
      - id: time
        type: time
        doc: 'Time'
      - id: client_message_type
        type: u1
        enum: client_message_type
        doc: 'Message number of a message sent by the user'
  user_name:
    seq:
      - id: user_name_length_byte
        type: u1
        doc: 'Count of characters in User Name'
      - id: user_name_characters
        type: str
        size: 15
        encoding: ASCII
        doc: 'User name as assigned by the exchange'
  time:
    seq:
      - id: hours
        type: u1
        doc: 'Hours'
      - id: minutes
        type: u1
        doc: 'Minutes'
      - id: seconds
        type: u1
        doc: 'Seconds'
      - id: unused_1
        size: 1
        doc: 'Unused'
  log_in_message:
    seq:
      - id: encrypted_password
        size: 312
        doc: 'Length of the encrypted password in the first 4 bytes, then the password encrypted with the session public key'
      - id: new_password
        size: 312
        doc: 'New password if the user requires to change their password'
  re_request_message:
    seq:
      - id: from_sequence
        type: s4
        doc: 'From this sequence number'
      - id: to_sequence
        type: s4
        doc: 'To this sequence number'
      - id: market_shard_number_i_4
        type: s4
        doc: 'Indicates the market shard number on which you would like to re-request data from'
  request_data_retrieval_message:
    seq:
      - id: data_type
        type: u1
        enum: data_type
        doc: 'File identifier requested'
      - id: unused_1
        size: 1
        doc: 'Unused'
      - id: last_piece_of_chunk
        type: u1
        doc: 'Not used for request'
      - id: re_request
        type: u1
        doc: 'Indicates if this is a re-request for data'
      - id: action
        type: s4
        enum: action
        doc: 'Not used for request'
      - id: specific_record
        type: s4
        doc: 'Allows the download of a specific record sequence number and onwards'
      - id: download_date
        type: download_date
        doc: 'Download Date'
  download_date:
    seq:
      - id: year
        type: s4
        doc: 'Year'
      - id: month
        type: s4
        doc: 'Month'
      - id: day
        type: s4
        doc: 'Day'
  unsubscribe_contract_message:
    seq:
      - id: quantity_i_2
        type: s2
        doc: 'Number of contracts to unsubscribe from'
      - id: contracts_to_unsubscribe
        type: contracts_to_unsubscribe
        repeat: expr
        repeat-expr: 40
        doc: 'Contracts to unsubscribe'
  contracts_to_unsubscribe:
    seq:
      - id: contract
        type: contract
        doc: 'Contract'
  contract:
    seq:
      - id: identifier_prefix_i_4
        type: s4
        doc: 'Defines the asset class of the contract'
      - id: date
        type: date
        doc: 'Date'
      - id: instrument_name_p_5
        type: instrument_name_p_5
        doc: 'Defines the instrument which represents this contract'
      - id: strike
        size: 8
        doc: 'For option contracts, indicates the strike price'
      - id: call_put_c_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'For option contracts, indicates if this is a Call or Put option contract'
      - id: secondary_date
        type: secondary_date
        doc: 'Secondary Date'
      - id: secondary_instrument_name_p_5
        type: secondary_instrument_name_p_5
        doc: 'For strategy type products such as Product spreads, represents the instrument name of the second leg of the contract'
      - id: is_delta_option
        type: u1
        doc: 'For option contracts, indicates if this is a Delta Neutral Option strategy'
  date:
    seq:
      - id: year
        type: s4
        doc: 'Year'
      - id: month
        type: s4
        doc: 'Month'
      - id: day
        type: s4
        doc: 'Day'
  instrument_name_p_5:
    seq:
      - id: instrument_name_p_5_length_byte
        type: u1
        doc: 'Count of characters in Instrument Name P 5'
      - id: instrument_name_p_5_characters
        type: str
        size: 4
        encoding: ASCII
        doc: 'Defines the instrument which represents this contract'
  secondary_date:
    seq:
      - id: year
        type: s4
        doc: 'Year'
      - id: month
        type: s4
        doc: 'Month'
      - id: day
        type: s4
        doc: 'Day'
  secondary_instrument_name_p_5:
    seq:
      - id: secondary_instrument_name_p_5_length_byte
        type: u1
        doc: 'Count of characters in Secondary Instrument Name P 5'
      - id: secondary_instrument_name_p_5_characters
        type: str
        size: 4
        encoding: ASCII
        doc: 'For strategy type products such as Product spreads, represents the instrument name of the second leg of the contract'
  request_daily_trend_message:
    seq:
      - id: contract_name
        type: contract_name
        doc: 'Contract Name'
  contract_name:
    seq:
      - id: identifier_prefix_i_4
        type: s4
        doc: 'Defines the asset class of the contract'
      - id: date
        type: date
        doc: 'Date'
      - id: instrument_name_p_5
        type: instrument_name_p_5
        doc: 'Defines the instrument which represents this contract'
      - id: strike
        size: 8
        doc: 'For option contracts, indicates the strike price'
      - id: call_put_c_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'For option contracts, indicates if this is a Call or Put option contract'
      - id: secondary_date
        type: secondary_date
        doc: 'Secondary Date'
      - id: secondary_instrument_name_p_5
        type: secondary_instrument_name_p_5
        doc: 'For strategy type products such as Product spreads, represents the instrument name of the second leg of the contract'
      - id: is_delta_option
        type: u1
        doc: 'For option contracts, indicates if this is a Delta Neutral Option strategy'
  option_contract_subscription_message:
    seq:
      - id: contract_name
        type: contract_name
        doc: 'Contract Name'
  subscribing_to_indices_service_message:
    seq:
      - id: subscribe
        type: u1
        doc: 'Indicates if the user would like to subscribe or unsubscribe from the service'
  future_contract_subscription_message:
    seq:
      - id: quantity_i_2
        type: s2
        doc: 'Number of contracts to unsubscribe from'
      - id: contracts_requested_for_display
        type: contracts_requested_for_display
        repeat: expr
        repeat-expr: 40
        doc: 'Contracts Requested For Display'
  contracts_requested_for_display:
    seq:
      - id: contract
        type: contract
        doc: 'Contract'
  option_statistics_request_message:
    seq:
      - id: contract_name
        type: contract_name
        doc: 'Contract Name'

enums:
  client_message_type:
    0:
      id: 'log_in_message'
      doc: 'Log in message.'
    3:
      id: 're_request_message'
      doc: 'Re-Request of 59 messages.'
    4:
      id: 'log_out_message'
      doc: 'This message does not contain any details.'
    36:
      id: 'request_data_retrieval_message'
      doc: 'Allows users to request data from the system.'
    37:
      id: 'request_data_retrieval_message_37'
      doc: 'Allows users to request data from the system.'
    42:
      id: 'unsubscribe_contract_message'
      doc: 'Unsubscribe from Display Updates on up to 40 contracts.'
    61:
      id: 'request_daily_trend_message'
      doc: 'Request the on screen trade history for a contract for the current trading session.'
    67:
      id: 'option_contract_subscription_message'
      doc: 'Subscribe to Display Updates on the contracts listed.'
    84:
      id: 'heart_beats_message'
      doc: 'This message contains only a header with message type 84.'
    98:
      id: 'subscribing_to_indices_service_message'
      doc: 'Subscribe or unsubscribe from the indices service.'
    99:
      id: 'future_contract_subscription_message'
      doc: 'Subscribe to Display Updates on up to 40 contracts.'
    135:
      id: 'option_statistics_request_message'
      doc: 'Request a Display Update with information for all option contracts traded since the beginning of the trading session.'
  data_type:
    1:
      id: 'market_display_data'
      doc: 'Market Display Data'
    2:
      id: 'instruments_data'
      doc: 'Instruments Data'
    3:
      id: 'contract_dates'
      doc: 'Contract Dates'
    4:
      id: 'strike_data'
      doc: 'Strike Data'
    15:
      id: 'member_data'
      doc: 'Member Data'
    16:
      id: 'mtm_data'
      doc: 'Mtm Data'
    18:
      id: 'holiday'
      doc: 'Holiday'
    65:
      id: 'clearing_member_data'
      doc: 'Clearing Member Data'
    89:
      id: 'exchange_announcements'
      doc: 'Exchange Announcements'
    129:
      id: 'news'
      doc: 'News'
    131:
      id: 'coupon_information'
      doc: 'Coupon Information'
    136:
      id: 'trading_sessions'
      doc: 'Trading Sessions'
    138:
      id: 'indices'
      doc: 'Indices'
    139:
      id: 'indices_data'
      doc: 'Indices Data'
    39:
      id: 'instrument_types'
      doc: 'Instrument Types'
    137:
      id: 'indices_price_data'
      doc: 'Indices Price Data'
    141:
      id: 'shares_in_issue_data'
      doc: 'Shares In Issue Data'
    146:
      id: 'index_data'
      doc: 'Index Data'
    147:
      id: 'index_constituents_data'
      doc: 'Index Constituents Data'
  action:
    0:
      id: 'file_download'
      doc: 'File Download'
    1:
      id: 'delete_field'
      doc: 'Delete'
    2:
      id: 'insert'
      doc: 'Insert'
    3:
      id: 'update'
      doc: 'Update'
  server_message_type:
    1:
      id: 'successful_log_in_response_message'
      doc: 'Returned to users when the user successfully authenticates to the system.'
    10:
      id: 'heart_beat_message'
      doc: 'A heartbeat message sent to the logged in member as simply a blank header.'
    16:
      id: 'session_key_challenge_message'
      doc: 'Returned to a user when a successful TCP socket connection is established to the system.'
    36:
      id: 'download_data_response_message'
      doc: 'Request Data Header and the compressed data returned.'
    37:
      id: 'download_data_response_message_37'
      doc: 'Request Data Header and the compressed data returned.'
    58:
      id: 'completed_trade_message'
      doc: 'Sent when an order has been matched or trading has occurred between two parties.'
    59:
      id: 'display_update_message'
      doc: 'Returned whenever on screen activity is recorded on a particular contract.'
    60:
      id: 'indices_message'
      doc: 'Each Index will be sent in this format.'
    61:
      id: 'daily_trend_reply_message'
      doc: 'On screen trade activity recorded on a particular contract.'
    99:
      id: 'price_update_message'
      doc: 'A 99 message is received in reply to a 99 message.'
    123:
      id: 'data_update_message'
      doc: 'Updates or inserts received intra-session, which always contains only one record.'
    125:
      id: 'exchange_announcements_message'
      doc: 'Error and information messages.'
    127:
      id: 'notification_of_failure_message'
      doc: 'Sent on the failure or the recovery of the exchange trading system.'
    132:
      id: 'business_message_reject_message'
      doc: 'Returned in response to an incoming message to indicate a failure to process this message for some business validation failure.'
  linked_to_floating_rate:
    0x4e:
      id: 'none'
      doc: 'None'
    0x43:
      id: 'cpi_index'
      doc: 'Cpi Index'
  price_rate:
    0x50:
      id: 'price'
      doc: 'Price'
    0x52:
      id: 'rate'
      doc: 'Rate'
  call_or_put:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  message_category_type:
    1:
      id: 'general'
      doc: 'General'
    2:
      id: 'instrument'
      doc: 'Instrument'
    3:
      id: 'sector'
      doc: 'Sector'
  trade_type:
    0:
      id: 'normal'
      doc: 'Normal'
    1:
      id: 'odd'
      doc: 'Odd'
  auction:
    0:
      id: 'contract_is_open'
      doc: 'Contract Is Open'
    1:
      id: 'contract_is_in_auction'
      doc: 'Contract Is In Auction'
    2:
      id: 'contract_is_closed'
      doc: 'Contract Is Closed'
    3:
      id: 'contract_is_suspended'
      doc: 'Contract Is Suspended'
    4:
      id: 'contract_in_open_order_period'
      doc: 'Contract In Open Order Period'
    5:
      id: 'contract_is_after_open_period'
      doc: 'Contract Is After Open Period'
    6:
      id: 'contract_instrument_has_been_halted'
      doc: 'Contract Instrument Has Been Halted'
  contract_status:
    0:
      id: 'bid_or_offer_activity_with_no_change_to_best_bid_or_offer'
      doc: 'Bid Or Offer Activity With No Change To Best Bid Or Offer'
    1:
      id: 'bid_activity_which_has_changed_the_best_bid_on_this_contract'
      doc: 'Bid Activity Which Has Changed The Best Bid On This Contract'
    2:
      id: 'offer_activity_which_has_changed_the_best_offer_on_this_contract'
      doc: 'Offer Activity Which Has Changed The Best Offer On This Contract'
    3:
      id: 'bid_or_offer_activity_which_has_changed_both_the_best_bid_and_offer_on_this_contract'
      doc: 'Bid Or Offer Activity Which Has Changed Both The Best Bid And Offer On This Contract'
    4:
      id: 'trade_activity_has_been_recorded_on_this_contract_with_no_change_to_the_best_bid_or_offer_indicates_that_the_close_price_has_updated'
      doc: 'Trade Activity Has Been Recorded On This Contract With No Change To The Best Bid Or Offer Indicates That The Close Price Has Updated'
    5:
      id: 'trade_activity_which_has_changed_the_best_bid_on_this_contract'
      doc: 'Trade Activity Which Has Changed The Best Bid On This Contract'
    6:
      id: 'trade_activity_which_has_changed_the_best_offer_on_this_contract'
      doc: 'Trade Activity Which Has Changed The Best Offer On This Contract'
    7:
      id: 'trade_activity_which_has_changed_the_best_bid_and_offer_on_this_contract'
      doc: 'Trade Activity Which Has Changed The Best Bid And Offer On This Contract'
  buy_order_type:
    0:
      id: 'normal'
      doc: 'Normal'
    1:
      id: 'take_or_kill'
      doc: 'Take Or Kill'
    2:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
    4:
      id: 'iceberg'
      doc: 'Iceberg'
    8:
      id: 'stop_order'
      doc: 'Stop Order'
    16:
      id: 'at_best'
      doc: 'At Best'
    32:
      id: 'all_or_nothing'
      doc: 'All Or Nothing'
    64:
      id: 'rebid'
      doc: 'Rebid'
    128:
      id: 'close_order'
      doc: 'Close Order'
    256:
      id: 'reverse_take_or_kill'
      doc: 'Reverse Take Or Kill'
    512:
      id: 'market_order_fill_or_kill'
      doc: 'Market Order Fill Or Kill'
    1024:
      id: 'run_order'
      doc: 'Run Order'
    2048:
      id: 'cover_order'
      doc: 'Cover Order'
    4096:
      id: 'market_order_take_or_kill'
      doc: 'Market Order Take Or Kill'
    16384:
      id: 'suspend_order'
      doc: 'Suspend Order'
    32768:
      id: 'good_till_cancelled_order'
      doc: 'Good Till Cancelled Order'
  sell_order_type:
    0:
      id: 'normal'
      doc: 'Normal'
    1:
      id: 'take_or_kill'
      doc: 'Take Or Kill'
    2:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
    4:
      id: 'iceberg'
      doc: 'Iceberg'
    8:
      id: 'stop_order'
      doc: 'Stop Order'
    16:
      id: 'at_best'
      doc: 'At Best'
    32:
      id: 'all_or_nothing'
      doc: 'All Or Nothing'
    64:
      id: 'rebid'
      doc: 'Rebid'
    128:
      id: 'close_order'
      doc: 'Close Order'
    256:
      id: 'reverse_take_or_kill'
      doc: 'Reverse Take Or Kill'
    512:
      id: 'market_order_fill_or_kill'
      doc: 'Market Order Fill Or Kill'
    1024:
      id: 'run_order'
      doc: 'Run Order'
    2048:
      id: 'cover_order'
      doc: 'Cover Order'
    4096:
      id: 'market_order_take_or_kill'
      doc: 'Market Order Take Or Kill'
    16384:
      id: 'suspend_order'
      doc: 'Suspend Order'
    32768:
      id: 'good_till_cancelled_order'
      doc: 'Good Till Cancelled Order'
  error_number:
    100:
      id: 'password_changed_successfully'
      doc: 'Password Changed Successfully'
    102:
      id: 'market_announcement'
      doc: 'Market Announcement'
    108:
      id: 'generic_market_interaction_message'
      doc: 'Generic Market Interaction Message'
    116:
      id: 'successful_client_loaded'
      doc: 'Successful Client Loaded'
    120:
      id: 'your_password_expires_in_x_days'
      doc: 'Your Password Expires In X Days'
    123:
      id: 'mark_to_market_rates_is_ready_for_download'
      doc: 'Mark To Market Rates Is Ready For Download'
    124:
      id: 'daily_rates_is_ready_for_download'
      doc: 'Daily Rates Is Ready For Download'
    126:
      id: 'the_re_request_service_is_currently_un_available_please_try_again_later'
      doc: 'The Re Request Service Is Currently Un Available Please Try Again Later'
    127:
      id: 'early_valuations_are_ready_for_download'
      doc: 'Early Valuations Are Ready For Download'
    2:
      id: 'order_quantity_below_minimum_2'
      doc: 'Order Quantity Below Minimum'
    3:
      id: 'bid_on_contract_was_not_a_multiple_of_the_lotsize_3'
      doc: 'Bid On Contract Was Not A Multiple Of The Lotsize'
    7:
      id: 'trading_on_this_contract_is_only_allowed_between_x_and_x'
      doc: 'Trading On This Contract Is Only Allowed Between X And X'
    8:
      id: 'your_bid_initial_margin_exceeds_your_limit'
      doc: 'Your Bid Initial Margin Exceeds Your Limit'
    12:
      id: 'invalid_data_in_bid_message_number_of_orders_exceeds_limit'
      doc: 'Invalid Data In Bid Message Number Of Orders Exceeds Limit'
    13:
      id: 'invalid_data_in_bid_message_incorrect_contract_name_or_contract_doesnt_exist'
      doc: 'Invalid Data In Bid Message Incorrect Contract Name Or Contract Doesnt Exist'
    18:
      id: 'could_not_find_index_for_contract_x'
      doc: 'Could Not Find Index For Contract X'
    19:
      id: 'could_not_create_strike'
      doc: 'Could Not Create Strike'
    20:
      id: 'not_a_buy_sell_order'
      doc: 'Not A Buy Sell Order'
    21:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    22:
      id: 'bid_outside_market_limits'
      doc: 'Bid Outside Market Limits'
    24:
      id: 'member_does_not_exist'
      doc: 'Member Does Not Exist'
    25:
      id: 'order_type_not_allowed'
      doc: 'Order Type Not Allowed'
    26:
      id: 'invalid_client_code'
      doc: 'Invalid Client Code'
    27:
      id: 'not_a_valid_member_code'
      doc: 'Not A Valid Member Code'
    28:
      id: 'not_a_valid_clearing_member_code'
      doc: 'Not A Valid Clearing Member Code'
    29:
      id: 'invalid_front_end_version_29'
      doc: 'Invalid Front End Version'
    30:
      id: 'invalid_front_end_version_30'
      doc: 'Invalid Front End Version'
    31:
      id: 'dealer_does_not_belong_to_member'
      doc: 'Dealer Does Not Belong To Member'
    32:
      id: 'cannot_book_deals_for_other_members'
      doc: 'Cannot Book Deals For Other Members'
    33:
      id: 'invalid_principal'
      doc: 'Invalid Principal'
    34:
      id: 'member_does_not_belong_to_clearing_member'
      doc: 'Member Does Not Belong To Clearing Member'
    35:
      id: 'cannot_book_deals_for_other_clearing_members'
      doc: 'Cannot Book Deals For Other Clearing Members'
    36:
      id: 'x_is_not_a_client_of_member'
      doc: 'X Is Not A Client Of Member'
    37:
      id: 'invalid_counterparty'
      doc: 'Invalid Counterparty'
    39:
      id: 'dealer_not_found'
      doc: 'Dealer Not Found'
    40:
      id: 'invalid_cancel_flag'
      doc: 'Invalid Cancel Flag'
    41:
      id: 'invalid_reference_number'
      doc: 'Invalid Reference Number'
    42:
      id: 'instrument_not_found'
      doc: 'Instrument Not Found'
    43:
      id: 'contract_date_not_found'
      doc: 'Contract Date Not Found'
    44:
      id: 'strike_not_found'
      doc: 'Strike Not Found'
    46:
      id: 'dealer_not_a_master_dealer'
      doc: 'Dealer Not A Master Dealer'
    47:
      id: 'foktok_order_cannot_be_satisfied'
      doc: 'Foktok Order Cannot Be Satisfied'
    48:
      id: 'all_or_nothing_not_allowed'
      doc: 'All Or Nothing Not Allowed'
    49:
      id: 'trading_on_this_contract_is_closed'
      doc: 'Trading On This Contract Is Closed'
    50:
      id: 'order_quantity_below_minimum_50'
      doc: 'Order Quantity Below Minimum'
    51:
      id: 'bid_on_contract_was_not_a_multiple_of_the_lotsize_51'
      doc: 'Bid On Contract Was Not A Multiple Of The Lotsize'
    52:
      id: 'invalid_spread'
      doc: 'Invalid Spread'
    53:
      id: 'odd_lots_not_allowed_when_underlying_in_auction'
      doc: 'Odd Lots Not Allowed When Underlying In Auction'
    54:
      id: 'not_allowed_to_change_subscription'
      doc: 'Not Allowed To Change Subscription'
    60:
      id: 'limits_specified_must_be_positive'
      doc: 'Limits Specified Must Be Positive'
    62:
      id: 'principal_agency_indicator_is_invalid'
      doc: 'Principal Agency Indicator Is Invalid'
    63:
      id: 'cannot_suspend_an_order_1_minute_before_the_end_of_open_order_period'
      doc: 'Cannot Suspend An Order 1 Minute Before The End Of Open Order Period'
    64:
      id: 'spreads_not_allowed_with_underlying_in_auction'
      doc: 'Spreads Not Allowed With Underlying In Auction'
    66:
      id: 'contract_is_suspended'
      doc: 'Contract Is Suspended'
    67:
      id: 'dealer_code_is_empty'
      doc: 'Dealer Code Is Empty'
    68:
      id: 'incorrect_price_format'
      doc: 'Incorrect Price Format'
    69:
      id: 'strike_cannot_be_loaded'
      doc: 'Strike Cannot Be Loaded'
    70:
      id: 'price_cannot_be_less_than_zero'
      doc: 'Price Cannot Be Less Than Zero'
    71:
      id: 'quantity_cannot_be_less_or_equal_to_zero'
      doc: 'Quantity Cannot Be Less Or Equal To Zero'
    72:
      id: 'must_be_a_master_dealer_to_perform_this_action'
      doc: 'Must Be A Master Dealer To Perform This Action'
    73:
      id: 'contract_not_a_valid_contract'
      doc: 'Contract Not A Valid Contract'
    74:
      id: 'the_active_order_selected_cannot_be_found'
      doc: 'The Active Order Selected Cannot Be Found'
    76:
      id: 'cannot_reduce_an_order_1_minute_before_end_of_open_order_period'
      doc: 'Cannot Reduce An Order 1 Minute Before End Of Open Order Period'
    77:
      id: 'cannot_resubmit_an_order_1_minute_before_end_of_open_order_period'
      doc: 'Cannot Resubmit An Order 1 Minute Before End Of Open Order Period'
    78:
      id: 'cannot_suspend_this_order_until_market_opens'
      doc: 'Cannot Suspend This Order Until Market Opens'
    80:
      id: 'this_order_type_has_not_been_enabled_on_this_contract'
      doc: 'This Order Type Has Not Been Enabled On This Contract'
    81:
      id: 'order_quantity_x_is_less_than_1_on_contract_x'
      doc: 'Order Quantity X Is Less Than 1 On Contract X'
    82:
      id: 'price_cannot_be_less_than_or_equal_to_0'
      doc: 'Price Cannot Be Less Than Or Equal To 0'
    83:
      id: 'this_order_cannot_be_deleted_as_it_is_currently_active_please_use_message_8'
      doc: 'This Order Cannot Be Deleted As It Is Currently Active Please Use Message 8'
    84:
      id: 'the_from_sequence_cannot_be_larger_than_the_to_sequence'
      doc: 'The From Sequence Cannot Be Larger Than The To Sequence'
    87:
      id: 'order_sequence_x_cannot_be_found'
      doc: 'Order Sequence X Cannot Be Found'
    101:
      id: 'invalid_password_or_incorrect_date'
      doc: 'Invalid Password Or Incorrect Date'
    103:
      id: 'invalid_old_password'
      doc: 'Invalid Old Password'
    104:
      id: 'submitted_on_screen_limit_invalid'
      doc: 'Submitted On Screen Limit Invalid'
    105:
      id: 'submitted_option_limit_invalid'
      doc: 'Submitted Option Limit Invalid'
    106:
      id: 'submitted_report_only_limit_invalid'
      doc: 'Submitted Report Only Limit Invalid'
    109:
      id: 'member_does_not_have_position_on_this_contract'
      doc: 'Member Does Not Have Position On This Contract'
    110:
      id: 'can_only_give_notice_for_delivery_on_a_short_position'
      doc: 'Can Only Give Notice For Delivery On A Short Position'
    111:
      id: 'cannot_give_notice_on_certificate_because_the_certificate_is_not_the_same_instrument_as_the_delivery_notice'
      doc: 'Cannot Give Notice On Certificate Because The Certificate Is Not The Same Instrument As The Delivery Notice'
    112:
      id: 'number_of_contracts_in_notice_exceeds_total_position'
      doc: 'Number Of Contracts In Notice Exceeds Total Position'
    113:
      id: 'silo_certificate_number_is_not_within_the_valid_range_for_this_silo'
      doc: 'Silo Certificate Number Is Not Within The Valid Range For This Silo'
    114:
      id: 'invalid_multiplication_factor'
      doc: 'Invalid Multiplication Factor'
    115:
      id: 'contact_details_error'
      doc: 'Contact Details Error'
    117:
      id: 'market_period_rule_error'
      doc: 'Market Period Rule Error'
    118:
      id: 'you_have_no_rights_to_perform_this_operation'
      doc: 'You Have No Rights To Perform This Operation'
    119:
      id: 'auction_notifications'
      doc: 'Auction Notifications'
    121:
      id: 'cannot_delete_a_certificate_which_is_ready_for_delivery_or_delivered'
      doc: 'Cannot Delete A Certificate Which Is Ready For Delivery Or Delivered'
    1000:
      id: 'generic_exception'
      doc: 'Generic Exception'
  information_or_error_indicator:
    0:
      id: 'information_message'
      doc: 'Information Message'
    1:
      id: 'error_message'
      doc: 'Error Message'
  failure_notice_identifier:
    1:
      id: 'market_shard_has_failed'
      doc: 'Market Shard Has Failed'
    2:
      id: 'market_shard_has_recovered'
      doc: 'Market Shard Has Recovered'

