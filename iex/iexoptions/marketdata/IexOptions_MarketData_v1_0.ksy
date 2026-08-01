# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexOptions MarketData Sbe v1.0
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Market Data
#   Encoding: Simple Binary Encoding
#   Version: 1.0
#   Date: 6/1/2026
#   Specification: IEX Options Market Data Transport Protocol Specification
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: iexoptions_marketdata_v1_0
  title: Iex IexOptions MarketData Sbe v1.0
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Options Market Data Sbe v1.0'
doc-ref: https://www.iexexchange.io/options

seq:
  - id: sbe_message
    type: sbe_message_struct
    repeat: eos
    doc: 'Iex Options length-framed Sbe Message'

types:
  sbe_message_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Total packet length in bytes including this field'
      - id: message_header
        type: message_header
        doc: 'Iex Options Sbe message header — message identifiers and length of message root'
      - id: payload
        size: packet_length - 2 - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::underlying_ref_data_message': underlying_ref_data_message
            'template_id::symbol_mapping_message': symbol_mapping_message
            'template_id::instrument_clear_message': instrument_clear_message
            'template_id::trading_status_message': trading_status_message
            'template_id::options_auction_summary_message': options_auction_summary_message
            'template_id::options_auction_width_update_message': options_auction_width_update_message
            'template_id::liquidity_event_notification_message': liquidity_event_notification_message
            'template_id::liquidity_event_execution_message': liquidity_event_execution_message
            'template_id::liquidity_event_cancel_message': liquidity_event_cancel_message
            'template_id::add_order_non_customer_message': add_order_non_customer_message
            'template_id::add_order_customer_message': add_order_customer_message
            'template_id::modify_order_message': modify_order_message
            'template_id::delete_order_message': delete_order_message
            'template_id::order_execution_message': order_execution_message
            'template_id::deep_trade_break_message': deep_trade_break_message
            'template_id::quote_update_no_customer_interest_message': quote_update_no_customer_interest_message
            'template_id::quote_update_customer_interest_message': quote_update_customer_interest_message
            'template_id::trade_message': trade_message
            'template_id::trade_correction_message': trade_correction_message
            'template_id::tops_trade_break_message': tops_trade_break_message
            'template_id::heartbeat_message': heartbeat_message
            'template_id::sequenced_packet_message': sequenced_packet_message
            'template_id::session_shutdown_message': session_shutdown_message
            'template_id::retransmission_request_message': retransmission_request_message
            'template_id::retransmission_response_message': retransmission_response_message
            'template_id::snapshot_header_message': snapshot_header_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Length of the message root before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema publishing the message (10000 market data, 20000 session, 20001 order entry business)'
      - id: version
        type: u2
        doc: 'Schema version'
  underlying_ref_data_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: underlying_symbol
        type: str
        size: 16
        encoding: ASCII
        doc: 'underlyingSymbol'
      - id: exchange_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'exchangeCode'
      - id: mpv_group
        type: s1
        enum: mpv_group
        doc: 'mpvGroup'
      - id: close_indicator
        type: s1
        enum: close_indicator
        doc: 'closeIndicator'
  symbol_mapping_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: osi_symbol
        type: str
        size: 32
        encoding: ASCII
        doc: 'osiSymbol'
      - id: trading_ring
        type: s1
        doc: 'tradingRing'
      - id: closing_only_series
        type: u1
        enum: closing_only_series
        doc: 'closingOnlySeries'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'maturityDate'
      - id: option_type
        type: s1
        enum: option_type
        doc: 'optionType'
      - id: strike_price
        type: s8
        doc: 'strikePrice. Implied decimal with scale 1e-8'
      - id: orp_enablement
        type: s1
        enum: orp_enablement
        doc: 'orpEnablement'
  instrument_clear_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
  trading_status_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
  options_auction_summary_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: auction_summary_type
        type: s1
        enum: auction_summary_type
        doc: 'auctionSummaryType'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
  options_auction_width_update_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: quote_relief_multiplier
        type: u1
        doc: 'quoteReliefMultiplier'
  liquidity_event_notification_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: event_id
        type: u4
        doc: 'eventId'
      - id: liquidity_event_type
        type: s1
        enum: liquidity_event_type
        doc: 'liquidityEventType'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
      - id: capacity
        type: s1
        enum: capacity
        doc: 'capacity'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'participantId'
      - id: event_end_offset
        type: u4
        doc: 'eventEndOffset'
  liquidity_event_execution_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: event_id
        type: u4
        doc: 'eventId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
  liquidity_event_cancel_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: event_id
        type: u4
        doc: 'eventId'
  add_order_non_customer_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
  add_order_customer_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
      - id: customer_indicator
        type: s1
        enum: customer_indicator
        doc: 'customerIndicator'
  modify_order_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
      - id: mod_flag
        type: s1
        enum: mod_flag
        doc: 'modFlag'
  delete_order_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: order_id
        type: u8
        doc: 'orderId'
  order_execution_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: executed_contracts
        type: u4
        doc: 'executedContracts'
      - id: remaining_contracts
        type: u4
        doc: 'remainingContracts'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'tradeCondition'
  deep_trade_break_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
  quote_update_no_customer_interest_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: bid_size
        type: u4
        doc: 'bidSize'
      - id: bid_price
        type: s8
        doc: 'bidPrice. Implied decimal with scale 1e-8'
      - id: ask_size
        type: u4
        doc: 'askSize'
      - id: ask_price
        type: s8
        doc: 'askPrice. Implied decimal with scale 1e-8'
      - id: status_status_type
        type: s1
        enum: status_status_type
        doc: 'status'
  quote_update_customer_interest_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: bid_size
        type: u4
        doc: 'bidSize'
      - id: bid_customer_size
        type: u4
        doc: 'bidCustomerSize'
      - id: bid_price
        type: s8
        doc: 'bidPrice. Implied decimal with scale 1e-8'
      - id: ask_size
        type: u4
        doc: 'askSize'
      - id: ask_customer_size
        type: u4
        doc: 'askCustomerSize'
      - id: ask_price
        type: s8
        doc: 'askPrice. Implied decimal with scale 1e-8'
      - id: status_status_type
        type: s1
        enum: status_status_type
        doc: 'status'
  trade_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'tradeCondition'
  trade_correction_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: original_trade_id
        type: u8
        doc: 'originalTradeId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: contracts
        type: u4
        doc: 'contracts'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'tradeCondition'
  tops_trade_break_message:
    seq:
      - id: time
        type: u8
        doc: 'time'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'tradeCondition'
  heartbeat_message:
    seq:
      - id: channel_id
        type: u4
        doc: 'channelId'
      - id: sequence_number
        type: u8
        doc: 'sequenceNumber'
  sequenced_packet_message:
    seq:
      - id: channel_id
        type: u4
        doc: 'channelId'
      - id: sequence_number
        type: u8
        doc: 'sequenceNumber'
      - id: sequenced_packet_message_messages_groups
        type: sequenced_packet_message_messages_groups
        doc: 'messages Block'
  sequenced_packet_message_messages_groups:
    seq:
      - id: message_list_group_encoding
        type: message_list_group_encoding
        doc: 'messageListGroupEncoding'
  message_list_group_encoding:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  session_shutdown_message:
    seq:
      - id: channel_id
        type: u4
        doc: 'channelId'
      - id: sequence_number
        type: u8
        doc: 'sequenceNumber'
  retransmission_request_message:
    seq:
      - id: begin_sequence
        type: u8
        doc: 'beginSequence'
      - id: end_sequence
        type: u8
        doc: 'endSequence'
      - id: logon_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'logonId'
      - id: request_id
        type: u4
        doc: 'requestId'
      - id: channel_id
        type: u4
        doc: 'channelId'
      - id: feed
        type: s1
        enum: feed
        doc: 'feed'
  retransmission_response_message:
    seq:
      - id: logon_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'logonId'
      - id: request_id
        type: u4
        doc: 'requestId'
      - id: channel_id
        type: u4
        doc: 'channelId'
      - id: feed
        type: s1
        enum: feed
        doc: 'feed'
      - id: status_retransmission_status_type
        type: u1
        enum: status_retransmission_status_type
        doc: 'status'
  snapshot_header_message:
    seq:
      - id: snapshot_id
        type: u4
        doc: 'snapshotId'
      - id: current_packet_number
        type: u4
        doc: 'currentPacketNumber'
      - id: total_packet_count
        type: u4
        doc: 'totalPacketCount'
      - id: as_of_sequence_number
        type: u8
        doc: 'asOfSequenceNumber'

enums:
  template_id:
    1:
      id: 'underlying_ref_data_message'
      doc: 'UnderlyingRefDataMessage'
    2:
      id: 'symbol_mapping_message'
      doc: 'SymbolMappingMessage'
    3:
      id: 'instrument_clear_message'
      doc: 'InstrumentClearMessage'
    4:
      id: 'trading_status_message'
      doc: 'TradingStatusMessage'
    5:
      id: 'options_auction_summary_message'
      doc: 'OptionsAuctionSummaryMessage'
    6:
      id: 'options_auction_width_update_message'
      doc: 'OptionsAuctionWidthUpdateMessage'
    7:
      id: 'liquidity_event_notification_message'
      doc: 'LiquidityEventNotificationMessage'
    8:
      id: 'liquidity_event_execution_message'
      doc: 'LiquidityEventExecutionMessage'
    9:
      id: 'liquidity_event_cancel_message'
      doc: 'LiquidityEventCancelMessage'
    100:
      id: 'add_order_non_customer_message'
      doc: 'AddOrderNonCustomerMessage'
    101:
      id: 'add_order_customer_message'
      doc: 'AddOrderCustomerMessage'
    102:
      id: 'modify_order_message'
      doc: 'ModifyOrderMessage'
    103:
      id: 'delete_order_message'
      doc: 'DeleteOrderMessage'
    104:
      id: 'order_execution_message'
      doc: 'OrderExecutionMessage'
    105:
      id: 'deep_trade_break_message'
      doc: 'DEEPTradeBreakMessage'
    200:
      id: 'quote_update_no_customer_interest_message'
      doc: 'QuoteUpdateNoCustomerInterestMessage'
    201:
      id: 'quote_update_customer_interest_message'
      doc: 'QuoteUpdateCustomerInterestMessage'
    202:
      id: 'trade_message'
      doc: 'TradeMessage'
    203:
      id: 'trade_correction_message'
      doc: 'TradeCorrectionMessage'
    204:
      id: 'tops_trade_break_message'
      doc: 'TOPSTradeBreakMessage'
    300:
      id: 'heartbeat_message'
      doc: 'HeartbeatMessage'
    301:
      id: 'sequenced_packet_message'
      doc: 'SequencedPacketMessage'
    302:
      id: 'session_shutdown_message'
      doc: 'SessionShutdownMessage'
    400:
      id: 'server_heartbeat_message'
      doc: 'ServerHeartbeatMessage'
    401:
      id: 'client_heartbeat_message'
      doc: 'ClientHeartbeatMessage'
    402:
      id: 'retransmission_request_message'
      doc: 'RetransmissionRequestMessage'
    403:
      id: 'retransmission_response_message'
      doc: 'RetransmissionResponseMessage'
    601:
      id: 'snapshot_header_message'
      doc: 'SnapshotHeaderMessage'
  mpv_group:
    0:
      id: 'all_penny'
      doc: 'MPVType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'penny_nickel'
      doc: 'MPVType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'nickel_dime'
      doc: 'MPVType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  close_indicator:
    0:
      id: 'default'
      doc: 'CloseIndicatorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'underlying_closed'
      doc: 'CloseIndicatorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  closing_only_series:
    0:
      id: 'false'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  option_type:
    0:
      id: 'put'
      doc: 'OptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'call'
      doc: 'OptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  orp_enablement:
    0:
      id: 'orp_protection_enabled'
      doc: 'ORPType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'orp_protection_disabled'
      doc: 'ORPType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_status:
    0:
      id: 'halted'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'pre_opening'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'opening_process'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'continuous_trading'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 're_opening_process'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'suspended'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'queueing'
      doc: 'TradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  auction_summary_type:
    0:
      id: 'opening'
      doc: 'AuctionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'halt_re_opening'
      doc: 'AuctionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  liquidity_event_type:
    0:
      id: 'sum'
      doc: 'LiquidityEventType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    1:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  capacity:
    0:
      id: 'customer'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'firm'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'broker_dealer'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'market_maker'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'away_market_maker'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'prof_customer'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'not_disclosed'
      doc: 'CapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  customer_indicator:
    0:
      id: 'customer'
      doc: 'CustIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'non_customer'
      doc: 'CustIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mod_flag:
    0:
      id: 'reset_priority'
      doc: 'ModFlagType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'maintain_priority'
      doc: 'ModFlagType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  status_status_type:
    0:
      id: 'regular_trading'
      doc: 'StatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'trading_halted'
      doc: 'StatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  feed:
    0:
      id: 'deep'
      doc: 'FeedType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'tops'
      doc: 'FeedType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  status_retransmission_status_type:
    0:
      id: 'success'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'invalid_channel_id'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'invalid_feed'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'invalid_logon_id'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_request_id'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_packet_length'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_message'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_seq_num_range'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'denial_of_service'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'max_daily_requests_exceeded'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'max_seq_num_range_exceeded'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'seq_num_ttl_expired'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'internal_error'
      doc: 'RetransmissionStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

