# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Nois Itch v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Net Order Imbalance Snapshot
#   Encoding: Itch
#   Version: 2.2
#   Date: 6/23/2025
#   Specification: NOIS_v2.2.pdf
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
  id: nasdaq_nsmequities_nois_itch_v2_2
  title: Nasdaq NsmEquities Nois Itch v2.2
  license: GPL-3.0
  endian: le

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Net Order Imbalance Snapshot Itch v2.2'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_body
        size: message_length + 2 - 2
        type:
          switch-on: message_length
          cases:
            _: message_data
  message_data:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp Message Header'
      - id: payload
        size: _parent.message_length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory': stock_directory
            'message_type::stock_trading_action': stock_trading_action
            'message_type::nois_message': nois_message
  message_header:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes below'
  stock_directory:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: rfu
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: round_lot_size
        size: 6
        doc: 'Indicates the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issues as assigned by Nasdaq. See Appendix for allowable values'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by Nasdaq. See Appendix for allowable values'
  stock_trading_action:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action reason'
  nois_message:
    seq:
      - id: imbalance_shares
        size: 9
        doc: 'Number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: near_price
        size: 10
        doc: 'A hypothetical auction-clearing price for cross orders as well as continuous orders'
      - id: current_reference_price
        size: 10
        doc: 'Indicates price at which the NOII shares are being calculated'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Denotes the type of Nasdaq cross for which the NOII message is being generated'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8be
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
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'stock_directory'
      doc: 'At the start of each trading day, Nasdaq disseminates stock directory messages for all active symbols in the Nasdaq execution system.'
    0x48:
      id: 'stock_trading_action'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x49:
      id: 'nois_message'
      doc: 'Nasdaq Net Order Imbalance Snapshot (NOIS) provides a snapshot of the Nasdaq net order imbalance data at selected time intervals.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. Outside of time stamp messages, the start of day message is the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that NASDAQ is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are available for execution.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are no longer available for execution.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Nasdaq is now closed and will not accept any new orders today. It is still possible to receive Broken Trade messages and Order Delete messages after the End of Day'
    0x43:
      id: 'end_of_messages'
      doc: 'This is always the last message sent in any trading day.'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange (NYSE)'
    0x41:
      id: 'nyse_amex'
      doc: 'NYSE Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x5a:
      id: 'bats_z_exchange'
      doc: 'BATS Z Exchange'
    0x4d:
      id: 'nyse_texas'
      doc: 'NYSE Texas'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors'' Exchange'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq system only accepts round lots'
    0x4e:
      id: 'no_restrictions'
      doc: 'Nasdaq system does not have any order size restrictions for this security. Odd and mixed lot orders are allowed.'
  issue_classification:
    0x41:
      id: 'american_depositary_share'
      doc: 'American Depositary Share'
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
      doc: 'Sec 144A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary_share'
      doc: 'Ordinary Share'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'right'
      doc: 'Right'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_benif_int'
      doc: 'Units/Benif Int'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted across all U.S. equity markets / SROs'
    0x50:
      id: 'paused'
      doc: 'Paused across all U.S. equity markets / SROs (Nasdaq-listed securities only)'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x54:
      id: 'trading'
      doc: 'Trading on Nasdaq'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'buy imbalance'
    0x53:
      id: 'sell'
      doc: 'sell imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'no imbalance'
    0x4f:
      id: 'insufficient'
      doc: 'insufficient orders to calculate'
  cross_type:
    0x4f:
      id: 'open_cross'
      doc: 'Open Cross'
    0x43:
      id: 'close_cross'
      doc: 'Close Cross'
    0x48:
      id: 'ipo_halt_cross'
      doc: 'Intra-day Opening Cross for IPO and Halted/Paused securities'

