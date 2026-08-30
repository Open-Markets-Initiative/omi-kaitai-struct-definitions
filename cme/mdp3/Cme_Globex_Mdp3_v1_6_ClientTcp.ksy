# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex Mdp3 Sbe v1.6
#
# Protocol:
#   Organization: CME Group
#   Protocol: Market Data Platform 3
#   Encoding: Simple Binary Encoding
#   Version: 1.6
#   Date: 1/09/2016
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: cme_globex_mdp3_sbe_v1_6_clienttcp
  title: Cme Globex Mdp3 Sbe v1.6
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Market Data Platform 3 Sbe v1.6'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+MDP+3.0+Market+Data

seq:
  - id: client_technical_header
    type: client_technical_header_struct
    doc: 'Cme Technical Header sent by the firm to Cme'
  - id: client_tcp_message
    type: client_tcp_message_struct
    repeat: eos
    doc: 'Cme Tcp Message sent by the firm to Cme'

types:
  client_technical_header_struct:
    seq:
      - id: encoding_type
        type: u2
        doc: 'Encoding Type'
      - id: message_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: tcp_sending_time
        type: u8
        doc: 'Packet Sending Time'
  client_tcp_message_struct:
    seq:
      - id: tcp_message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: client_payload
        size: tcp_message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::negotiate': negotiate
            'template_id::terminate': terminate
            'template_id::market_data_request': market_data_request
            'template_id::security_list_request': security_list_request
            'template_id::security_status_request': security_status_request
  message_header:
    seq:
      - id: block_length
        type: u2
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
  negotiate:
    seq:
      - id: hmac_signature
        type: str
        size: 32
        encoding: ASCII
        doc: 'Contains the HMAC signature'
      - id: access_key_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contains the AccessKeyID assigned to this session on this port'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: session
        type: str
        size: 5
        encoding: ASCII
        doc: 'Session ID'
      - id: firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Firm ID'
  terminate:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: error_codes
        type: u1
        enum: error_codes
        doc: 'Error code for reject reason'
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
  market_data_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: market_data_request_security_groups
        type: market_data_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: market_data_request_related_symbol_groups
        type: market_data_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  market_data_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: market_data_request_security_group
        type: market_data_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  market_data_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  market_data_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: market_data_request_related_symbol_group
        type: market_data_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  market_data_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  security_list_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: security_list_request_security_groups
        type: security_list_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: security_list_request_related_symbol_groups
        type: security_list_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  security_list_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_list_request_security_group
        type: security_list_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  security_list_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  security_list_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_list_request_related_symbol_group
        type: security_list_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  security_list_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  security_status_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: security_status_request_security_groups
        type: security_status_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: security_status_request_related_symbol_groups
        type: security_status_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  security_status_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_status_request_security_group
        type: security_status_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  security_status_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  security_status_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_status_request_related_symbol_group
        type: security_status_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  security_status_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000

enums:
  template_id:
    4:
      id: 'channel_reset'
      doc: 'ChannelReset'
    12:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
    15:
      id: 'admin_login'
      doc: 'AdminLogin'
    16:
      id: 'admin_logout'
      doc: 'AdminLogout'
    27:
      id: 'md_instrument_definition_future'
      doc: 'MDInstrumentDefinitionFuture'
    29:
      id: 'md_instrument_definition_spread'
      doc: 'MDInstrumentDefinitionSpread'
    30:
      id: 'security_status'
      doc: 'SecurityStatus'
    32:
      id: 'md_incremental_refresh_book'
      doc: 'MDIncrementalRefreshBook'
    33:
      id: 'md_incremental_refresh_daily_statistics'
      doc: 'MDIncrementalRefreshDailyStatistics'
    34:
      id: 'md_incremental_refresh_limits_banding'
      doc: 'MDIncrementalRefreshLimitsBanding'
    35:
      id: 'md_incremental_refresh_session_statistics'
      doc: 'MDIncrementalRefreshSessionStatistics'
    36:
      id: 'md_incremental_refresh_trade'
      doc: 'MDIncrementalRefreshTrade'
    37:
      id: 'md_incremental_refresh_volume'
      doc: 'MDIncrementalRefreshVolume'
    38:
      id: 'snapshot_full_refresh'
      doc: 'SnapshotFullRefresh'
    39:
      id: 'quote_request'
      doc: 'QuoteRequest'
    41:
      id: 'md_instrument_definition_option'
      doc: 'MDInstrumentDefinitionOption'
    42:
      id: 'md_incremental_refresh_trade_summary'
      doc: 'MDIncrementalRefreshTradeSummary'
    200:
      id: 'negotiate'
      doc: 'Negotiate'
    201:
      id: 'negotiation_reject'
      doc: 'NegotiationReject'
    202:
      id: 'negotiation_response'
      doc: 'NegotiationResponse'
    203:
      id: 'terminate'
      doc: 'Terminate'
    205:
      id: 'market_data_request'
      doc: 'MarketDataRequest'
    206:
      id: 'request_ack'
      doc: 'RequestAck'
    207:
      id: 'request_reject'
      doc: 'RequestReject'
    208:
      id: 'security_list_request'
      doc: 'SecurityListRequest'
    209:
      id: 'security_status_request'
      doc: 'SecurityStatusRequest'
    210:
      id: 'subscriber_heartbeat'
      doc: 'SubscriberHeartbeat'
  security_update_action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
    0x4d:
      id: 'modify'
      doc: 'Modify'
  md_security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading Halt'
    4:
      id: 'close'
      doc: 'Close'
    15:
      id: 'new_price_indication'
      doc: 'New Price Indication'
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    20:
      id: 'unknown_or_invalid'
      doc: 'Unknown or Invalid'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    24:
      id: 'pre_cross'
      doc: 'Pre Cross'
    25:
      id: 'cross'
      doc: 'Cross'
    26:
      id: 'post_close'
      doc: 'Post Close'
    103:
      id: 'no_change'
      doc: 'No Change'
  event_type:
    5:
      id: 'activation'
      doc: 'Activation'
    7:
      id: 'last_eligible_trade_date'
      doc: 'Last Eligible Trade Date'
  leg_side:
    1:
      id: 'buy_side'
      doc: 'Buy Side'
    2:
      id: 'sell_side'
      doc: 'Sell Side'
  security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading Halt'
    4:
      id: 'close'
      doc: 'Close'
    15:
      id: 'new_price_indication'
      doc: 'New Price Indication'
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    20:
      id: 'unknownor_invalid'
      doc: 'Unknown or Invalid'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    24:
      id: 'pre_cross'
      doc: 'Pre Cross'
    25:
      id: 'cross'
      doc: 'Cross'
    26:
      id: 'post_close'
      doc: 'Post Close'
    103:
      id: 'no_change'
      doc: 'No Change'
  halt_reason:
    0:
      id: 'group_schedule'
      doc: 'Group Schedule'
    1:
      id: 'surveillance_intervention'
      doc: 'Surveillance Intervention'
    2:
      id: 'market_event'
      doc: 'Market Event'
    3:
      id: 'instrument_activation'
      doc: 'Instrument Activation'
    4:
      id: 'instrument_expiration'
      doc: 'Instrument Expiration'
    5:
      id: 'unknown'
      doc: 'Unknown'
    6:
      id: 'recovery_in_process'
      doc: 'Recovery In Process'
  security_trading_event:
    0:
      id: 'no_event'
      doc: 'No Event'
    1:
      id: 'no_cancel'
      doc: 'No Cancel'
    4:
      id: 'reset_statistics'
      doc: 'Reset Statistics'
    5:
      id: 'implied_matching_on'
      doc: 'Implied Matching ON'
    6:
      id: 'implied_matching_off'
      doc: 'Implied Matching OFF'
  md_update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete_field'
      doc: 'Delete'
    3:
      id: 'delete_thru'
      doc: 'Delete Thru'
    4:
      id: 'delete_from'
      doc: 'Delete From'
    5:
      id: 'overlay'
      doc: 'Overlay'
  md_entry_type_book:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x45:
      id: 'implied_bid'
      doc: 'Implied Bid'
    0x46:
      id: 'implied_offer'
      doc: 'Implied Offer'
    0x4a:
      id: 'book_reset'
      doc: 'Book Reset'
  md_entry_type_daily_statistics:
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x42:
      id: 'cleared_volume'
      doc: 'Cleared Volume'
    0x43:
      id: 'open_interest'
      doc: 'Open Interest'
    0x57:
      id: 'fixing_price'
      doc: 'Fixing Price'
  open_close_settl_flag:
    0:
      id: 'daily_open_price'
      doc: 'Daily Open Price'
    5:
      id: 'indicative_opening_price'
      doc: 'Indicative Opening Price'
  md_entry_type_statistics:
    0x34:
      id: 'open_price'
      doc: 'Open Price'
    0x37:
      id: 'high_trade'
      doc: 'High Trade'
    0x38:
      id: 'low_trade'
      doc: 'Low Trade'
    0x4e:
      id: 'highest_bid'
      doc: 'Highest Bid'
    0x4f:
      id: 'lowest_offer'
      doc: 'Lowest Offer'
  aggressor_side:
    0:
      id: 'no_aggressor'
      doc: 'No Aggressor'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x32:
      id: 'trade'
      doc: 'Trade'
    0x34:
      id: 'open_price'
      doc: 'Open Price'
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x37:
      id: 'trading_session_high_price'
      doc: 'Trading Session High Price'
    0x38:
      id: 'trading_session_low_price'
      doc: 'Trading Session Low Price'
    0x42:
      id: 'cleared_volume'
      doc: 'Cleared Volume'
    0x43:
      id: 'open_interest'
      doc: 'Open Interest'
    0x45:
      id: 'implied_bid'
      doc: 'Implied Bid'
    0x46:
      id: 'implied_offer'
      doc: 'Implied Offer'
    0x4a:
      id: 'book_reset'
      doc: 'Book Reset'
    0x4e:
      id: 'session_high_bid'
      doc: 'Session High Bid'
    0x4f:
      id: 'session_low_offer'
      doc: 'Session Low Offer'
    0x57:
      id: 'fixing_price'
      doc: 'Fixing Price'
    0x65:
      id: 'electronic_volume'
      doc: 'Electronic Volume'
    0x67:
      id: 'threshold_limitsand_price_band_variation'
      doc: 'Threshold Limits and Price Band Variation'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put Option'
    1:
      id: 'call'
      doc: 'Call Option'
  error_codes:
    0:
      id: 'hmac_reject'
      doc: 'Failed authentication'
    1:
      id: 'invalid_value'
      doc: 'Failed required field validation'
    2:
      id: 'slow_connection'
      doc: 'Slow connection'
    3:
      id: 'other'
      doc: 'Unexpected request, see Reason field for details'
  subscription_req_type:
    0:
      id: 'snapshot'
      doc: 'Snapshot'
    1:
      id: 'snapshot_and_updates'
      doc: 'Snapshot and updates'
    2:
      id: 'unsubscribe'
      doc: 'Disable previous subscription'
  md_req_id_status:
    0:
      id: 'full_ack'
      doc: 'Requested subscription scope is fully acknowledged'
    1:
      id: 'partial_ack'
      doc: 'Requested subscription scope is partially acknowledged'
  md_req_rej_reason:
    0:
      id: 'unknown_security'
      doc: 'Unknown Security'
    1:
      id: 'unknown_message'
      doc: 'Unknown or Invalid Message'
    2:
      id: 'unsupported_scope'
      doc: 'Unsupported Scope'
    3:
      id: 'other'
      doc: 'Other'

