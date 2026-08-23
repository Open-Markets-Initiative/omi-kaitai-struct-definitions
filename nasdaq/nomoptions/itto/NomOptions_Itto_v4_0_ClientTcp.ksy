# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NomOptions Itto Itch v4.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Itch To Trade Options
#   Encoding: Itch
#   Version: 4.0
#   Date: 01/09/2023
#   Specification: itto_spec40.pdf
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
  id: nasdaq_nomoptions_itto_itch_v4_0_clienttcp
  title: Nasdaq NomOptions Itto Itch v4.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Options Market Itch To Trade Options Itch v4.0'
doc-ref: https://business.nasdaq.com/trade/US-Options/Technical-Specifications.html

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_tcp_packet_header
        type: client_tcp_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_tcp_payload
        size: client_tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_tcp_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_tcp_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_tcp_packet_header.packet_length - 2
        doc: 'The unsequenced (client to server) message carried by the packet, opaque bytes unless an application source dispatches it'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, NASDAQ disseminates options symbol directory messages for all active options symbols in the NASDAQ option system.'
    0x48:
      id: 'trading_action_message'
      doc: 'After the start of system hours, NASDAQ will use the Trading Action message to relay changes in trading status for an individual option. Messages will be sent when an option is halted, is released for quotation, released for trading, or temporarily suspended for trading on the buy or sell side.'
    0x4f:
      id: 'security_open_message'
      doc: 'NASDAQ plans to disseminate the Option Open Message for each option as soon as the opening is completed. Upon receipt of the open state message, firms should be advised that the option denoted in the message is now available for auto execution within the NASDAQ Options Market System. Upon receipt of the closed state message, firms should be advised that the option is no longer eligible for auto-execution within the NASDAQ Options Market System.'
    0x61:
      id: 'add_order_message_short_message_form'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x41:
      id: 'add_order_message_long_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x6a:
      id: 'add_quote_message_short_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x4a:
      id: 'add_quote_message_long_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x45:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part. It is possible to receive several Single Side Executed Messages for the same Side order if that Side order is executed in several parts. The multiple Single Side Executed Messages on the same order are cumulative. By combining the executions received separately via two types of Single Side Executed Messages and Trade Messages, it is possible to build a complete view of all non-auction executions that happen on NASDAQ. Auction execution information is available in one bulk print via the Auction Trade Message.'
    0x43:
      id: 'single_side_executed_with_price_message'
      doc: 'These executions may be marked as non-printable. If the execution is marked as non-printed, it means that the contracts will be included into a later bulk print (e.g., in the case of auction executions). If a firm is looking to use the ITTO data in time-and-sales displays or volume calculations, NASDAQ recommends that firms ignore messages marked as non-printable to prevent double counting.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_message_short_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x55:
      id: 'single_side_replace_message_long_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_change_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts. The reference number associated with the order quote is unchanged.'
    0x6b:
      id: 'quote_replace_message_short_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x4b:
      id: 'quote_replace_message_long_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x50:
      id: 'options_trade_messages_non_auction'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-displayable order types. (Note: There is a separate message for NASDAQ Option auction events.)'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'This message will also be used to report all executions within a price improvement (PRISM) auction.'
    0x42:
      id: 'broken_trade_order_executed_message'
      doc: 'The Broken Trade Message is sent whenever an execution on NASDAQ is broken. An execution may be broken if it is found to be “clearly erroneous” pursuant to NASDAQ’s Clearly Erroneous Policy. A trade break is final; once a trade is broken, it cannot be reinstated.'
    0x49:
      id: 'noii_message'
      doc: 'For the NASDAQ Opening Auction, NASDAQ will begin the dissemination of NOII messages for a put or a call option five minutes prior to the start of opening process event and two minutes prior to the halt resumption (reopening) process event.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages This Is Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process This Message Is Intended To Indicate That Nasdaq Has Started Its Opening Auction Process'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing This Message Is Intended To Indicate That Nasdaq Will No Longer Accept Any New Orders Or Changes To Existing Orders For Options That Trade During Normal Trading Hours'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing This Message Is Intended To Indicate That Nasdaq Will No Longer Accept Any New Orders Or Changes To Existing Orders For Options That Trade During Extended Hours'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours This Message Indicates That Nasdaq Options System Is Now Closed'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages This Is Always The Last Message Sent In Any Trading Day'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  options_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x4c:
      id: 'late'
      doc: 'Late'
  tradable:
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
    0x59:
      id: 'is_tradable'
      doc: 'Is Tradable'
  mpv:
    0x45:
      id: 'everywhere'
      doc: 'Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'pilot'
      doc: 'Pilot'
  current_trading_state:
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x42:
      id: 'buy_side_trading_suspended'
      doc: 'Buy Side Trading Suspended'
    0x53:
      id: 'sell_side_trading_suspended'
      doc: 'Sell Side Trading Suspended'
  open_state:
    0x59:
      id: 'open'
      doc: 'Open'
    0x4e:
      id: 'closed'
      doc: 'Closed'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable:
    0x4e:
      id: 'nonprintable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
    0x52:
      id: 'reprice'
      doc: 'Reprice'
    0x53:
      id: 'suspend'
      doc: 'Suspend'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  cross_type:
    0x4f:
      id: 'nasdaq_opening_reopening'
      doc: 'Nasdaq Opening Reopening'
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement'
    0x49:
      id: 'exposure'
      doc: 'Exposure'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  customer_firm_indicator:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm_joint'
      doc: 'Firm Joint'
    0x4d:
      id: 'onfloor'
      doc: 'Onfloor'
    0x50:
      id: 'professional'
      doc: 'Professional'
    0x42:
      id: 'broker_dealer_non_registered'
      doc: 'Broker Dealer Non Registered'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, NASDAQ disseminates options symbol directory messages for all active options symbols in the NASDAQ option system.'
    0x48:
      id: 'trading_action_message'
      doc: 'After the start of system hours, NASDAQ will use the Trading Action message to relay changes in trading status for an individual option. Messages will be sent when an option is halted, is released for quotation, released for trading, or temporarily suspended for trading on the buy or sell side.'
    0x4f:
      id: 'security_open_message'
      doc: 'NASDAQ plans to disseminate the Option Open Message for each option as soon as the opening is completed. Upon receipt of the open state message, firms should be advised that the option denoted in the message is now available for auto execution within the NASDAQ Options Market System. Upon receipt of the closed state message, firms should be advised that the option is no longer eligible for auto-execution within the NASDAQ Options Market System.'
    0x61:
      id: 'add_order_message_short_message_form'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x41:
      id: 'add_order_message_long_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x6a:
      id: 'add_quote_message_short_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x4a:
      id: 'add_quote_message_long_form_message'
      doc: 'For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x45:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part. It is possible to receive several Single Side Executed Messages for the same Side order if that Side order is executed in several parts. The multiple Single Side Executed Messages on the same order are cumulative. By combining the executions received separately via two types of Single Side Executed Messages and Trade Messages, it is possible to build a complete view of all non-auction executions that happen on NASDAQ. Auction execution information is available in one bulk print via the Auction Trade Message.'
    0x43:
      id: 'single_side_executed_with_price_message'
      doc: 'These executions may be marked as non-printable. If the execution is marked as non-printed, it means that the contracts will be included into a later bulk print (e.g., in the case of auction executions). If a firm is looking to use the ITTO data in time-and-sales displays or volume calculations, NASDAQ recommends that firms ignore messages marked as non-printable to prevent double counting.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_message_short_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x55:
      id: 'single_side_replace_message_long_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_change_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts. The reference number associated with the order quote is unchanged.'
    0x6b:
      id: 'quote_replace_message_short_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x4b:
      id: 'quote_replace_message_long_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x50:
      id: 'options_trade_messages_non_auction'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-displayable order types. (Note: There is a separate message for NASDAQ Option auction events.)'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'This message will also be used to report all executions within a price improvement (PRISM) auction.'
    0x42:
      id: 'broken_trade_order_executed_message'
      doc: 'The Broken Trade Message is sent whenever an execution on NASDAQ is broken. An execution may be broken if it is found to be “clearly erroneous” pursuant to NASDAQ’s Clearly Erroneous Policy. A trade break is final; once a trade is broken, it cannot be reinstated.'
    0x49:
      id: 'noii_message'
      doc: 'For the NASDAQ Opening Auction, NASDAQ will begin the dissemination of NOII messages for a put or a call option five minutes prior to the start of opening process event and two minutes prior to the halt resumption (reopening) process event.'

