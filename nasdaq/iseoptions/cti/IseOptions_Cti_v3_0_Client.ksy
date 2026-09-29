# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions Cti Itch v3.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Clearing Trade Interface
#   Encoding: Itch
#   Version: 3.0
#   Date: 08/03/2026
#   Specification: Options_ETH_CTI.pdf
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
  id: nasdaq_iseoptions_cti_itch_v3_0_client
  title: Nasdaq IseOptions Cti Itch v3.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Clearing Trade Interface Itch v3.0'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/resources/options-specifications-and-resources-hub
  - https://www.nasdaq.com/Options_ETH_CTI
  - https://www.nasdaq.com/Options_CTI

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
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
      - id: debug_text
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
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
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
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message is used to signal a ring wide event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, the exchange disseminates directory messages for all symbols trading on a given ring. Sent once per symbol, typically before the Start of System Hours System Event; intra-day updates are sent as they occur.'
    0x52:
      id: 'complex_order_strategy_message'
      doc: 'The strategy associated to a complex order (PHLX, ISE and MRX only). The Strategy ID assigned for a new complex strategy is unique for a particular complex instrument for a trading session, however Strategy IDs are independent of session Option IDs and uniqueness across complex and simple options is not guaranteed.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'Indicates the current trading status of an option within the exchange. A T (Trading resumed) message is sent for all options eligible for trading at the start of system hours; a security absent from the pre-opening spin should be treated as halted.'
    0x49:
      id: 'complex_trading_action_message'
      doc: 'Indicates the current trading status of a strategy within the exchange (PHLX, ISE and MRX only). A T (Trading Resumed) message is sent for all strategies eligible for trading at the start of system hours.'
    0x54:
      id: 'trade_message'
      doc: 'Clearing trades and trade corrections, with contra side clearing information (trade cancels too when a firm and connection block is configured for extended cancels, Transaction Type Z). 337 bytes. Contra side clearing fields carry a Contra prefix.'
    0x56:
      id: 'cancel_trade_message'
      doc: 'By default CTI sends trade cancels using this message; alternatively a firm and connection block can be configured to send extended cancels with all the trade information using the Trade message with Transaction Type Z. 66 bytes.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages Always The First Message Sent In Any Trading Day After 400 Am'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours The Exchange Is Ready To Start Accepting Orders 700 Am'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process The Exchange Has Started Its Opening Process 93000 Am'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing No New Orders Or Changes To Existing Orders For Options That Trade During Normal Hours 40000 Pm'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing No New Orders Or Changes To Existing Orders For Options That Trade During Extended Hours 41500 Pm'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours The System Is Now Closed 530 Pm'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages Always The Last Message Sent In Any Trading Day 535 Pm'
  option_kind:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  option_closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'non_tradable'
      doc: 'Non Tradable'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'Penny Everywhere All Prices Are In Penny Increments'
    0x53:
      id: 'scaled'
      doc: 'Scaled Prices Below 3.00 Are In Increments Of 0.05 Prices Above 3.00 Are In Increments Of 0.10'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot Prices Below 3.00 Are In Increments Of 0.01 Prices Above 3.00 Are In Increments Of 0.05'
  closing_only:
    0x59:
      id: 'closing_position_only'
      doc: 'Option Is Closing Position Only Only Mm Origin Orders Can Have Open Position In The Series'
    0x4e:
      id: 'not_closing_position_only'
      doc: 'Option Is Not Closing Position Only'
  action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
  leg_option_kind:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'Leg Is On Buy Side'
    0x53:
      id: 'sell'
      doc: 'Leg Is On Sell Side'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  send_type:
    0x53:
      id: 'send'
      doc: 'Send Original Transmission'
    0x50:
      id: 'possible_duplicate'
      doc: 'Possible Duplicate Unsolicited Retransmission'
  transaction_type:
    0x58:
      id: 'new_trade'
      doc: 'New Trade'
    0x59:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x5a:
      id: 'trade_cancel'
      doc: 'Trade Cancel If Trade Cancel Messages Are To Be Sent Using This Message'
  liquidity:
    1:
      id: 'add_maker'
      doc: 'Add Maker'
    2:
      id: 'remove_taker'
      doc: 'Remove Taker'
    4:
      id: 'response'
      doc: 'Response'
    5:
      id: 'hidden'
      doc: 'Hidden'
    6:
      id: 'opening_trade'
      doc: 'Opening Trade'
    7:
      id: 'cross'
      doc: 'Cross'
    8:
      id: 'flashed_order'
      doc: 'Flashed Order'
    9:
      id: 'flash_response'
      doc: 'Flash Response'
    10:
      id: 'routed_out'
      doc: 'Routed Out'
    11:
      id: 'trade_report'
      doc: 'Trade Report'
    12:
      id: 'combo_maker_against_combo'
      doc: 'Combo Maker Against Combo'
    13:
      id: 'combo_taker_against_combo'
      doc: 'Combo Taker Against Combo'
    14:
      id: 'combo_response_against_combo'
      doc: 'Combo Response Against Combo'
    15:
      id: 'combo_hidden_against_combo'
      doc: 'Combo Hidden Against Combo'
    16:
      id: 'combo_opening_rotation'
      doc: 'Combo Opening Rotation'
    17:
      id: 'combo_cross'
      doc: 'Combo Cross'
    18:
      id: 'combo_taker_against_regular'
      doc: 'Combo Taker Against Regular'
    19:
      id: 'regular_maker_against_combo'
      doc: 'Regular Maker Against Combo'
    20:
      id: 'combo_taker_against_io'
      doc: 'Combo Taker Against Io'
    21:
      id: 'regular_taker_against_io'
      doc: 'Regular Taker Against Io Incl Pim'
    23:
      id: 'io_maker_against_regular'
      doc: 'Io Maker Against Regular'
    24:
      id: 'regular_maker_against_io_participant'
      doc: 'Regular Maker Against Io Participant'
    25:
      id: 'io_participant_taker_against_regular'
      doc: 'Io Participant Taker Against Regular'
    26:
      id: 'broken_price_improvement'
      doc: 'Broken Price Improvement'
    27:
      id: 'broken_facilitation'
      doc: 'Broken Facilitation'
    28:
      id: 'broken_solicitation'
      doc: 'Broken Solicitation'
    29:
      id: 'combo_broken_price_improvement'
      doc: 'Combo Broken Price Improvement'
    30:
      id: 'combo_broken_facilitation'
      doc: 'Combo Broken Facilitation'
    31:
      id: 'combo_broken_solicitation'
      doc: 'Combo Broken Solicitation'
    32:
      id: 'block'
      doc: 'Block'
    33:
      id: 'block_response'
      doc: 'Block Response'
    34:
      id: 'directed_response'
      doc: 'Directed Response'
    35:
      id: 'facilitation'
      doc: 'Facilitation'
    36:
      id: 'facilitation_response'
      doc: 'Facilitation Response'
    37:
      id: 'price_improvement'
      doc: 'Price Improvement'
    38:
      id: 'price_improvement_response'
      doc: 'Price Improvement Response'
    39:
      id: 'solicitation'
      doc: 'Solicitation'
    40:
      id: 'solicitation_response'
      doc: 'Solicitation Response'
    41:
      id: 'qualified_contingent_cross'
      doc: 'Qualified Contingent Cross'
    42:
      id: 'customer_to_customer'
      doc: 'Customer To Customer'
    43:
      id: 'combo_facilitation'
      doc: 'Combo Facilitation'
    44:
      id: 'combo_facilitation_response'
      doc: 'Combo Facilitation Response'
    45:
      id: 'combo_price_improvement'
      doc: 'Combo Price Improvement'
    46:
      id: 'combo_price_improvement_response'
      doc: 'Combo Price Improvement Response'
    47:
      id: 'combo_solicitation'
      doc: 'Combo Solicitation'
    48:
      id: 'combo_solicitation_response'
      doc: 'Combo Solicitation Response'
    49:
      id: 'combo_qualified_contingent_cross'
      doc: 'Combo Qualified Contingent Cross'
    50:
      id: 'combo_customer_to_customer'
      doc: 'Combo Customer To Customer'
    51:
      id: 'sweep_routed_out'
      doc: 'Sweep Routed Out'
    52:
      id: 'sweep_trade_report'
      doc: 'Sweep Trade Report'
    53:
      id: 'combo_taker_against_regular_thru_nbbo'
      doc: 'Combo Taker Against Regular Thru Nbbo'
    55:
      id: 'simple_exposure_order_upon_receipt'
      doc: 'Simple Exposure Order Upon Receipt'
    57:
      id: 'simple_exposure_order_responder'
      doc: 'Simple Exposure Order Responder'
    58:
      id: 'flex_auction'
      doc: 'Flex Auction'
    59:
      id: 'flex_auction_responder'
      doc: 'Flex Auction Responder'
    60:
      id: 'flex_price_improvement'
      doc: 'Flex Price Improvement'
    61:
      id: 'flex_price_improvement_responder'
      doc: 'Flex Price Improvement Responder'
    62:
      id: 'flex_broken_price_improvement'
      doc: 'Flex Broken Price Improvement'
    63:
      id: 'flex_solicitation'
      doc: 'Flex Solicitation'
    64:
      id: 'flex_solicitation_responder'
      doc: 'Flex Solicitation Responder'
    65:
      id: 'flex_broken_solicitation'
      doc: 'Flex Broken Solicitation'
    66:
      id: 'combo_flex_auction'
      doc: 'Combo Flex Auction'
    67:
      id: 'combo_flex_auction_responder'
      doc: 'Combo Flex Auction Responder'
    68:
      id: 'combo_flex_price_improvement'
      doc: 'Combo Flex Price Improvement'
    69:
      id: 'combo_flex_price_improvement_responder'
      doc: 'Combo Flex Price Improvement Responder'
    70:
      id: 'combo_flex_broken_price_improvement'
      doc: 'Combo Flex Broken Price Improvement'
    71:
      id: 'combo_flex_solicitation'
      doc: 'Combo Flex Solicitation'
    72:
      id: 'combo_flex_solicitation_responder'
      doc: 'Combo Flex Solicitation Responder'
    73:
      id: 'combo_flex_broken_solicitation'
      doc: 'Combo Flex Broken Solicitation'
  auction_type:
    0x50:
      id: 'simple_order_pixl_prism_pim'
      doc: 'Simple Order Pixlprismpim'
    0x51:
      id: 'complex_order_pixl_pim'
      doc: 'Complex Order Pixlpim'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x43:
      id: 'complex_order_live_auction'
      doc: 'Complex Order Live Auction Colaise Exposure Auction Cao'
    0x53:
      id: 'simple_order_solicitation'
      doc: 'Simple Order Solicitation'
    0x52:
      id: 'complex_order_solicitation'
      doc: 'Complex Order Solicitation'
    0x46:
      id: 'simple_facilitation'
      doc: 'Simple Facilitation'
    0x47:
      id: 'complex_facilitation'
      doc: 'Complex Facilitation'
    0x42:
      id: 'block'
      doc: 'Block'
    0x58:
      id: 'flex_auction'
      doc: 'Flex Auction Phlx And Ise Only'
    0x59:
      id: 'complex_flex_auction'
      doc: 'Complex Flex Auction Phlx And Ise Only'
    0x20:
      id: 'no_auction'
      doc: 'No Auction'
  execution_type:
    0x41:
      id: 'automatic'
      doc: 'Automatic'
    0x4d:
      id: 'manual'
      doc: 'Manual'
  execution_market:
    0x41:
      id: 'amex'
      doc: 'Amex'
    0x42:
      id: 'box_field'
      doc: 'Box'
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x57:
      id: 'c_2'
      doc: 'C 2'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x58:
      id: 'phlx'
      doc: 'Phlx'
    0x54:
      id: 'ntx_options'
      doc: 'Ntx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x48:
      id: 'gemx'
      doc: 'Gemx'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'mrx'
      doc: 'Mrx'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x53:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x47:
      id: 'mx_2'
      doc: 'Mx 2'
    0x20:
      id: 'not_away_trade'
      doc: 'Not Away Trade Stock Legs On Phlxisemrx'
  trade_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  side_changed:
    0x59:
      id: 'yes_field'
      doc: 'New Trades And Corrections That Affected This Side Of The Trade'
    0x4e:
      id: 'no_field'
      doc: 'Corrections That Affected Only Contra Side'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4d:
      id: 'exchange_registered_market_maker'
      doc: 'Exchange Registered Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Stock Leg Execution Or Routed Away Execution'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
    0x46:
      id: 'firm'
      doc: 'Firm'
  origin_market:
    0x41:
      id: 'amex'
      doc: 'Amex'
    0x42:
      id: 'box_field'
      doc: 'Box'
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x57:
      id: 'c_2'
      doc: 'C 2'
    0x58:
      id: 'phlx'
      doc: 'Phlx'
    0x54:
      id: 'ntx_options'
      doc: 'Ntx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x48:
      id: 'gemx'
      doc: 'Gemx'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'mrx'
      doc: 'Mrx'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x53:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x47:
      id: 'mx_2'
      doc: 'Mx 2'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable The Capacity Of This Side Of Trade Is Not O'
  contra_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer'
    0x52:
      id: 'retail_customer'
      doc: 'Retail Customer'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4d:
      id: 'exchange_registered_market_maker'
      doc: 'Exchange Registered Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Stock Leg Execution Or Routed Away Execution'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x66:
      id: 'proprietary_firm'
      doc: 'Proprietary Firm'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer Firm'
  short_sell:
    0x59:
      id: 'short_sale'
      doc: 'Short Sale'
    0x4e:
      id: 'not_a_short_sale'
      doc: 'Not A Short Sale'
    0x45:
      id: 'short_sale_exempt'
      doc: 'Short Sale Exempt'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Not A Stock Leg'
  principal_agent:
    0x41:
      id: 'agency'
      doc: 'Agency Order'
    0x50:
      id: 'principal'
      doc: 'Principle'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principle'
    0x20:
      id: 'not_a_stock_leg'
      doc: 'Not A Stock Leg'
  origin_type:
    0x4f:
      id: 'fix_order'
      doc: 'Fix Order'
    0x43:
      id: 'fix_complex_order'
      doc: 'Fix Complex Order'
    0x54:
      id: 'otto_order'
      doc: 'Otto Order'
    0x5a:
      id: 'otto_complex_order'
      doc: 'Otto Complex Order'
    0x51:
      id: 'sqf_quote'
      doc: 'Sqf Quote'
    0x57:
      id: 'sqf_sweep'
      doc: 'Sqf Sweep'
    0x53:
      id: 'sqf_complex_sweep'
      doc: 'Sqf Complex Sweep'
    0x50:
      id: 'block_order'
      doc: 'Block Order'
    0x58:
      id: 'block_response'
      doc: 'Block Response'
    0x47:
      id: 'pim_primary_order'
      doc: 'Pixlprismpim Primary Order'
    0x48:
      id: 'pim_contra_order'
      doc: 'Pixlprismpim Contra Order'
    0x49:
      id: 'pim_response_order'
      doc: 'Pixlprismpim Response Order'
    0x4a:
      id: 'pim_response_sqf_sweep'
      doc: 'Pixlprismpim Response Sqf Sweep'
    0x67:
      id: 'pim_primary_complex_order'
      doc: 'Pixlpim Primary Complex Order'
    0x68:
      id: 'pim_contra_complex_order'
      doc: 'Pixlpim Contra Complex Order'
    0x69:
      id: 'pim_response_complex_order'
      doc: 'Pixlpim Response Complex Order'
    0x6a:
      id: 'pim_response_sqf_complex_sweep'
      doc: 'Pixlpim Response Sqf Complex Sweep'
    0x42:
      id: 'fbms_floor_trade'
      doc: 'Fbms Floor Trade'
    0x4b:
      id: 'qcc_primary'
      doc: 'Qcc Primary'
    0x4c:
      id: 'qcc_contra'
      doc: 'Qcc Contra'
    0x4d:
      id: 'solicitation_primary_order'
      doc: 'Solicitation Primary Order'
    0x4e:
      id: 'solicitation_contra_order'
      doc: 'Solicitation Contra Order'
    0x55:
      id: 'solicitation_response_order'
      doc: 'Solicitation Response Order'
    0x56:
      id: 'solicitation_response_sqf_sweep'
      doc: 'Solicitation Response Sqf Sweep'
    0x6d:
      id: 'solicitation_primary_complex_order'
      doc: 'Solicitation Primary Complex Order'
    0x6e:
      id: 'solicitation_contra_complex_order'
      doc: 'Solicitation Contra Complex Order'
    0x75:
      id: 'solicitation_response_complex_order'
      doc: 'Solicitation Response Complex Order'
    0x76:
      id: 'solicitation_response_sqf_complex_sweep'
      doc: 'Solicitation Response Sqf Complex Sweep'
    0x46:
      id: 'facilitation_primary_order'
      doc: 'Facilitation Primary Order'
    0x41:
      id: 'facilitation_contra_order'
      doc: 'Facilitation Contra Order'
    0x44:
      id: 'facilitation_response_order'
      doc: 'Facilitation Response Order'
    0x59:
      id: 'facilitation_response_sqf_sweep'
      doc: 'Facilitation Response Sqf Sweep'
    0x66:
      id: 'facilitation_primary_complex_order'
      doc: 'Facilitation Primary Complex Order'
    0x61:
      id: 'facilitation_contra_complex_order'
      doc: 'Facilitation Contra Complex Order'
    0x64:
      id: 'facilitation_response_complex_order'
      doc: 'Facilitation Response Complex Order'
    0x79:
      id: 'facilitation_response_sqf_complex_sweep'
      doc: 'Facilitation Response Sqf Complex Sweep'
    0x20:
      id: 'others'
      doc: 'Others'
    0x30:
      id: 'simple_flex_initiator'
      doc: 'Simple Flex Initiator'
    0x31:
      id: 'simple_flex_response_order'
      doc: 'Simple Flex Response Order'
    0x32:
      id: 'simple_flex_response_sqf_sweep'
      doc: 'Simple Flex Response Sqf Sweep'
    0x33:
      id: 'complex_flex_initiator'
      doc: 'Complex Flex Initiator'
    0x34:
      id: 'complex_flex_response_order'
      doc: 'Complex Flex Response Order'
    0x35:
      id: 'complex_flex_response_sqf_sweep'
      doc: 'Complex Flex Response Sqf Sweep'
  tif:
    0x49:
      id: 'ioc_or_fok'
      doc: 'Ioc Or Fok'
    0x44:
      id: 'day'
      doc: 'Day'
    0x47:
      id: 'gtc'
      doc: 'Gtc'
    0x4f:
      id: 'opg'
      doc: 'Opg'
    0x54:
      id: 'gtd'
      doc: 'Gtd'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Quotes Manual Trades'

