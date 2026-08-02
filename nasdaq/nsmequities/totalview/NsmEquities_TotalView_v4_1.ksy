# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v4.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 4.1
#   Date: 06/12/2014
#   Specification: NQTV-ITCH-V4_1.pdf
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
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nsmequities_totalview_v4_1
  title: Nasdaq NsmEquities TotalView Itch v4.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v4.1'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::timestamp_message': timestamp_message
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::market_participant_position_message': market_participant_position_message
            'message_type::add_order_message': add_order_message
            'message_type::add_order_with_mpid_message': add_order_with_mpid_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::trade_message': trade_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
            'message_type::retail_price_improvement_indicator_message': retail_price_improvement_indicator_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  timestamp_message:
    seq:
      - id: second
        type: u4
        doc: 'Number of seconds since midnight. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Code'
  stock_directory_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For NASDAQ-listed issues, this field indicates when a firm is not in compliance with NASDAQ continued listing requirements. For NYSE, NYSE Amex and NYSE Arca issues, this field will also be space-filled'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  market_participant_position_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the market participant identifier for which the position message is being generated'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: primary_market_maker
        type: u1
        enum: primary_market_maker
        doc: 'Indicates if the market participant firm qualifies as a Primary Market Maker in accordance with NASDAQ marketplace rules'
      - id: market_maker_mode
        type: u1
        enum: market_maker_mode
        doc: 'Indicates the quoting participant’s registration status in relation to SEC Rules 101 and 104 of Regulation M'
      - id: market_participant_state
        type: u1
        enum: market_participant_state
        doc: 'Indicates the market participant’s current registration status in the issue'
  add_order_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  add_order_with_mpid_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: attribution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NASDAQ market participant identifier associated with the entered order'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays and volume calculations'
      - id: execution_price
        type: u4
        doc: 'The price at which the order execution occurred. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  order_cancel_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: canceled_shares
        type: u4
        doc: 'The number of shares being removed from the display size of the order as the result of a cancellation'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: original_order_reference_number
        type: u8
        doc: 'The original reference number of the order being replaced'
      - id: new_order_reference_number
        type: u8
        doc: 'The new reference number for this order at time of replacement. Please note that the NASDAQ system will use this new order reference number for all subsequent updates'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
  trade_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: price
        type: u4
        doc: 'The display price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
  cross_trade_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: cross_shares
        type: u8
        doc: 'The number of shares matched in the NASDAQ Cross'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: cross_price
        type: u4
        doc: 'The price at which the cross occurred. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: match_number
        type: u8
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The NASDAQ cross session for which the message is being generated'
  broken_trade_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: match_number
        type: u8
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
  net_order_imbalance_indicator_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: paired_shares
        type: u8
        doc: 'The total number of shares that are eligible to be matched at the Current Reference Price'
      - id: imbalance_shares
        type: u8
        doc: 'The number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'The market side of the order imbalance'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: far_price
        type: u4
        doc: 'A hypothetical auction-clearing price for cross orders only. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: near_price
        type: u4
        doc: 'A hypothetical auction-clearing price for cross orders as well as continuous orders. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: current_reference_price
        type: u4
        doc: 'The price at which the NOII shares are being calculated. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The NASDAQ cross session for which the message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'This field indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'
  retail_price_improvement_indicator_message:
    seq:
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ execution system'
      - id: interest_flag
        type: u1
        enum: interest_flag

enums:
  message_type:
    0x54:
      id: 'timestamp_message'
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event. The format is as follows:'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data redistributors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for NASDAQ-listed issues.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'For NASDAQ-listed issues, NASDAQ will support a full pre-opening spin of Reg SHO Short Sale Price Test Restricted Indicator messages indicating the Rule 201 status for all active issues.'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'NASDAQ will send out this message only if NASDAQ Operations changes the status of a market participant firm in an issue.'
    0x41:
      id: 'add_order_message'
      doc: 'This message will be generated for unattributed orders accepted by the NASDAQ system.'
    0x46:
      id: 'add_order_with_mpid_message'
      doc: 'This message will be generated for attributed orders and quotations accepted by the NASDAQ system.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being canceled.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for normal match events involving non-displayable order types.'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that NASDAQ has completed its cross process for a specific security.'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade Message is sent whenever an execution on NASDAQ is broken.'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'NASDAQ disseminates NOII data at 5-second intervals in the minutes leading up to the NASDAQ Opening Cross and NASDAQ Closing Cross'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both the Bid and Ask for NASDAQ-listed securities.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today It Is Still Possible To Receive Broken Trade Messages And Order Delete Messages After The End Of Day'
    0x43:
      id: 'end_of_message'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
    0x41:
      id: 'halt'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That The Emc Is In Effect No Trading Is Allowed During The Emc'
    0x52:
      id: 'quote_only_period'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That The Emc Quotation Only Period Is In Effect'
    0x42:
      id: 'resumption'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That Emc Is No Longer In Effect'
  market_category:
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'amex'
      doc: 'New York Stock Exchange Amex'
    0x50:
      id: 'arca'
      doc: 'New York Stock Exchange Arca'
    0x51:
      id: 'nasdaq_gsm'
      doc: 'Nasdaq Global Select Marke'
    0x47:
      id: 'nasdaq_gm'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_cm'
      doc: 'Nasdaq Capital Market'
    0x5a:
      id: 'bats'
      doc: 'Bats Bzx Exchange'
  financial_status_indicator:
    0x44:
      id: 'delinquent'
      doc: 'Delinquent'
    0x45:
      id: 'deficient'
      doc: 'Deficient'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
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
  reg_sho_action:
    0x30:
      id: 'no_price'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'reg_sho_short_sale_price_test'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  primary_market_maker:
    0x59:
      id: 'primary'
      doc: 'Primary Market Maker'
    0x4e:
      id: 'nonprimary'
      doc: 'Nonprimary Market Maker'
  market_maker_mode:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x53:
      id: 'syndicate'
      doc: 'Syndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused_withdrawn'
      doc: 'Excused Withdrawn'
    0x57:
      id: 'withdrawn'
      doc: 'Withdrawn'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'nonprintable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'closing'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'cross_for_ipo_and_halted'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x49:
      id: 'nasdaq_cross_network'
      doc: 'Nasdaq Cross Network Intraday Cross And Post Close Cross'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
  price_variation_indicator:
    0x4c:
      id: 'less'
      doc: 'Less Than 1'
    0x31:
      id: 'value_x31'
      doc: '1 To 199'
    0x32:
      id: 'value_x32'
      doc: '2 To 299'
    0x33:
      id: 'value_x33'
      doc: '3 To 399'
    0x34:
      id: 'value_x34'
      doc: '4 To 499'
    0x35:
      id: 'value_x35'
      doc: '5 To 599'
    0x36:
      id: 'value_x36'
      doc: '6 To 699'
    0x37:
      id: 'value_x37'
      doc: '7 To 799'
    0x38:
      id: 'value_x38'
      doc: '8 To 899'
    0x39:
      id: 'value_x39'
      doc: '9 To 999'
    0x41:
      id: 'value_x41'
      doc: '10 To 1999'
    0x42:
      id: 'value_x42'
      doc: '20 To 2999'
    0x43:
      id: 'value_x43'
      doc: '30 Or Greater'
    0x20:
      id: 'no_calculation'
      doc: 'Cannot Be Calculated'
  interest_flag:
    0x42:
      id: 'rpi_buy'
      doc: 'Rpi Orders Available On The Buy Side'
    0x53:
      id: 'rpi_sell'
      doc: 'Rpi Orders Available On The Sell Side'
    0x41:
      id: 'rpi_both'
      doc: 'Rpi Orders Available On Both Sides Buy And Sell'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi Orders Available'

